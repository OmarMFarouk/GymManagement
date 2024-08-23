import 'dart:io';

import 'package:gymmanagement/blocs/employee_bloc/employee_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../models/clients_model.dart';
import '../../src/app_db.dart';
import 'package:image_picker/image_picker.dart';
import 'Clients_states.dart';

class ClientsCubit extends Cubit<ClientsStates> {
  ClientsCubit() : super(ClientsInitial());
  static ClientsCubit get(context) => BlocProvider.of(context);

  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController durationCont = TextEditingController();
  TextEditingController amountCont = TextEditingController();
  String type = 'حديد';
  List<Client> clientsList = [];
  Database? dbInstance = AppDB.database;
  String fileImage = '';

  void setClientImage({required int id}) async {
    final imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    final appDirectory = await getApplicationDocumentsDirectory();
    final imageDirectory = Directory('${appDirectory.path}/clients');

    if (!await imageDirectory.exists()) {
      await imageDirectory.create(recursive: true);
    }

    final newImagePath = '${appDirectory.path}/clients/$id.png';
    if (image != null) {
      await image.saveTo(newImagePath);
      await dbInstance!.execute('UPDATE clients SET image = ?  WHERE id = ?',
          [newImagePath, id]).then((value) {
        emit(ClientsSuccess(msg: 'تم اضافة صورة المشترك بنجاح'));
        clearConts();
        fetchClients();
      }).catchError((error) {
        emit(ClientsError(msg: error.toString()));
      });
    }
  }

  fetchClients() async {
    if (clientsList.isNotEmpty) {
      clientsList.clear();
    }
    emit(ClientsLoading());
    var queryList =
        (await dbInstance!.rawQuery('SELECT * FROM clients ORDER BY id DESC '))
            .toList() as List<Map<String, dynamic>>;
    for (var i = 0; i < queryList.length; i++) {
      clientsList.add(Client.fromJson(queryList[i]));
    }

    emit(ClientsInitial());
  }

  addClient() async {
    emit(ClientsLoading());
    List checkingQuery = await dbInstance!.rawQuery(
        'SELECT * FROM clients WHERE phone = ? ', [int.parse(phoneCont.text)]);
    if (checkingQuery.isEmpty) {
      await dbInstance!.execute(
          'INSERT INTO clients(name,phone,type,current_duration,date_created,last_renewal,image) VALUES (?,?,?,?,?,?,?)',
          [
            nameCont.text,
            phoneCont.text,
            type,
            int.parse(durationCont.text),
            DateTime.now().toString(),
            DateTime.now().toString(),
            ''
          ]).then((value) async {
        List<Map<String, dynamic>> result =
            await dbInstance!.query('clients', orderBy: 'id DESC', limit: 1);

        await dbInstance!.execute(
            'INSERT INTO subscriptions(client_id,amount,duration,date_created,type) VALUES (?,?,?,?,?)',
            [
              result.first['id'],
              int.parse(amountCont.text),
              int.parse(durationCont.text),
              DateTime.now().toString(),
              type,
            ]);
        await dbInstance!.execute(
            'INSERT INTO treasury(comment,amount,type,date_created,created_by) VALUES (?,?,?,?,?)',
            [
              'أشتراك',
              int.parse(amountCont.text),
              'إيداع',
              DateTime.now().toString(),
              currentEmployee.username,
            ]);
        dbInstance!.execute(
            'UPDATE analytics SET profit = profit + ? ,new_clients = new_clients + 1 WHERE date = ?',
            [
              int.parse(amountCont.text),
              DateTime.now().toString().split(' ').first
            ]);
        emit(ClientsSuccess(msg: 'تم اضافة المشترك بنجاح'));
        clearConts();
        fetchClients();
      }).catchError((error) {
        emit(ClientsError(msg: error.toString()));
      });
    } else {
      emit(ClientsError(msg: 'العميل مُسجل بالفعل'));
    }
  }

  updateClient(
      {required int id, required String name, required String phone}) async {
    emit(ClientsLoading());

    await dbInstance!.execute(
        'UPDATE clients SET name = ? , phone = ? WHERE id = ?',
        [name, phone, id]).then((value) {
      emit(ClientsSuccess(msg: 'تم تعديل المشترك بنجاح'));
      clearConts();
      fetchClients();
    }).catchError((error) {
      emit(ClientsError(msg: error.toString()));
    });
  }

  deleteClient({required int id}) async {
    emit(ClientsLoading());

    await dbInstance!
        .execute('DELETE FROM clients WHERE id = ?', [id]).then((value) {
      emit(ClientsSuccess(msg: ' نم مسح المشترك بنجاح'));
      clearConts();
      fetchClients();
    }).catchError((error) {
      emit(ClientsError(msg: error.toString()));
    });
  }

  renewClient(
      {required String cType,
      required int id,
      required int amount,
      required int duration}) async {
    emit(ClientsLoading());

    await dbInstance!.execute(
        'UPDATE clients SET type = ?,last_renewal = ? , current_duration = ? WHERE id = ?',
        [cType, DateTime.now().toString(), duration, id]).then((value) async {
      await dbInstance!.execute(
          'INSERT INTO subscriptions(client_id,amount,duration,date_created,type) VALUES (?,?,?,?,?)',
          [
            id,
            amount,
            duration,
            DateTime.now().toString(),
            cType,
          ]);
      emit(ClientsSuccess(msg: 'تم اضافة المشترك بنجاح'));
      clearConts();
      fetchClients();
    }).catchError((error) {
      emit(ClientsError(msg: error.toString()));
    });
  }

  clearConts() {
    nameCont.clear();
    phoneCont.clear();
    amountCont.clear();
    durationCont.clear();
  }
}
