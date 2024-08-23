import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmanagement/src/app_db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'analytics_states.dart';

class AnalyticsCubit extends Cubit<AnalyticsStates> {
  AnalyticsCubit() : super(AnalyticsInitial());
  static AnalyticsCubit get(context) => BlocProvider.of(context);
  Database? dbInstance = AppDB.database;
  List<Map<String, dynamic>> usersAnalytics = [];
  List<Map<String, dynamic>> profitAnalytics = [];

  fetchUsersAnalytics() async {
    if (usersAnalytics.isNotEmpty) {
      usersAnalytics.clear();
    }
    emit(AnalyticsLoaded());
    var queryList = (await dbInstance!
            .rawQuery('SELECT * FROM analytics ORDER BY id DESC '))
        .toList() as List<Map<String, dynamic>>;
    for (var i = 0; i < queryList.length; i++) {
      usersAnalytics.add({
        "date": queryList[i]['date'].split(' ').first,
        "value": double.parse(queryList[i]['new_clients'].toString())
      });
    }

    emit(AnalyticsInitial());
  }

  fetchProfitAnalytics() async {
    if (profitAnalytics.isNotEmpty) {
      profitAnalytics.clear();
    }
    emit(AnalyticsLoaded());
    var queryList = (await dbInstance!
            .rawQuery('SELECT * FROM analytics ORDER BY id DESC '))
        .toList() as List<Map<String, dynamic>>;
    for (var i = 0; i < queryList.length; i++) {
      profitAnalytics.add({
        "date": queryList[i]['date'].split(' ').first,
        "value": double.parse(queryList[i]['profit'].toString())
      });
    }

    emit(AnalyticsInitial());
  }
}
