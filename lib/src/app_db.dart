import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AppDB {
  static Database? database;
  static Future createDatabase() async {
    await openDatabase(
      'gym.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        await database
            .execute(
                'CREATE TABLE clients(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone INTEGER, type TEXT, current_duration INTEGER, date_created TEXT, last_renewal TEXT , image TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error Table ${error.toString()}');
        });
        await database
            .execute(
                'CREATE TABLE employees(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, last_access TEXT, date_created TEXT, role TEXT,salary INTEGER,phone INTEGER)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error Table ${error.toString()}');
        });
        await database
            .execute(
                'CREATE TABLE subscriptions(id INTEGER PRIMARY KEY AUTOINCREMENT , client_id INTEGER, amount INTEGER, duration INTEGER, date_created TEXT,type TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error Table ${error.toString()}');
        });
        await database
            .execute(
                'CREATE TABLE treasury(id INTEGER PRIMARY KEY AUTOINCREMENT , comment TEXT, amount INTEGER, type TEXT, date_created TEXT,created_by TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error Table ${error.toString()}');
        });
        await database
            .execute(
                'CREATE TABLE analytics(id INTEGER PRIMARY KEY AUTOINCREMENT , date TEXT, profit INTEGER, new_clients INTEGER)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error Table ${error.toString()}');
        });
        await database
            .execute(
                'CREATE TABLE attendance(id INTEGER PRIMARY KEY AUTOINCREMENT , date TEXT, username TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error Table ${error.toString()}');
        });
      },
      onOpen: (database) async {
        var analyticsChecker = (await database
                .rawQuery('SELECT * FROM analytics ORDER BY id DESC '))
            .toList() as List<Map<String, dynamic>>;
        if (analyticsChecker.isEmpty) {
          database.execute(
              'INSERT INTO analytics(date,profit,new_clients) VALUES (?,?,?)',
              [DateTime.now().toString().split(' ').first, 0, 0]).then((value) {
            print('analytics added');
          }).catchError((error) {
            if (!error.toString().contains('duplicate column name')) {
              print('Error Adding Column ${error.toString()}');
            }
          });
        }
      },
    ).then((value) {
      database = value;
    });
  }

  Future insertDatabase({
    required String name,
    required amount,
    required String code,
    required String price,
    required String discount,
  }) async {
    return await database?.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO data(name, amount, code, price, discount) VALUES(?, ?, ?, ?, ?)',
          [name, amount, code, price, discount]).then((value) {
        print("$value inserted into database");

        // getDatabase(database);
      }).catchError((error) {
        print('Error Inserting $error');
      });
    });
  }

  // void getDatabase(database) {
  //   database.rawQuery('SELECT * FROM data').then((value) {
  //     data = value;
  //     print(data);
  //     emit(AppGetDatabaseState());
  //   });
  // }

  // void updateDatabase(
  //     {required String name,
  //     required amount,
  //     required String code,
  //     required String price,
  //     required int id}) {
  //   database?.rawUpdate(
  //       'UPDATE data SET name = ?, amount = ?, code = ?, price = ? WHERE id = ?',
  //       [name, amount, code, price, id]).then((value) {
  //     getDatabase(database);
  //     emit(AppUpdateDatabase());
  //   }).catchError((onError) {
  //     print(onError.toString());
  //   });
  // }

  // void deleteDatabase({required int id}) async {
  //   database?.rawDelete('DELETE FROM data WHERE id = ?', [id]).then((value) {
  //     getDatabase(database);
  //     emit(AppDeleteDatabase());
  //   });
  // }

  // Future<Map?> getItemByCode(String code) async {
  //   List<Map> result =
  //       await database?.rawQuery('SELECT * FROM data WHERE code = ?', [code]) ??
  //           [];
  //   if (result.isNotEmpty) {
  //     return result.first;
  //   }
  //   return null;
  // }

  // void updateQuantity(String code, int amount, String discount) {
  //   var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //   database?.rawUpdate(
  //     'UPDATE data SET amount = amount - ?, date = ?, discount = ? WHERE code = ?',
  //     [amount, date, discount, code],
  //   ).then((value) {
  //     getDatabase(database);
  //     emit(AppUpdateDatabase());
  //   }).catchError((onError) {
  //     print(onError.toString());
  //   });
  // }

  // Future<List<Map>> getSalesByDate(String date) async {
  //   return await database
  //           ?.rawQuery('SELECT * FROM data WHERE date = ?', [date]) ??
  //       [];
  // }
}
