import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/network/local/cash_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  var isDark = false;
  void changeMode({bool? themeIndicator}) {
    if (themeIndicator != null) {
      isDark = themeIndicator;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CashHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  late Database database;
  List<Map>? readLater = [];
  List<Map>? favorites = [];

  void createDatabase() {
    /// open database
    /// note: creates database file and add table if not exist

    openDatabase(
      'newsAppDataBase.dp', //path to database
      version: 1, // database version

      onCreate: (database, version) async {
        print('[info] trying to create database');
        await database.execute('''
        CREATE TABLE "articles" (
        "id" INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT,
        "urlToImage" TEXT,
        "title" TEXT,
        "publishedAt" TEXT,
        "url" TEXT,
        "author" TEXT,
        "saveTime" Text,
        "type" TEXT
        )''');
      },

      onOpen: (database) {
        getFromDatabase(database);
        print('[info] database was opened successfully');
      },
    ).then((value) => {database = value, emit(AppDatabaseCreateState())});
  }

  insertToDatabase({required String query}) async {
    /// insert rou into database table

    await database.transaction((txn) {
      txn.rawInsert(query).then((value) {
        emit(AppDatabaseInsertState());
        getFromDatabase(database);
        print('[info]$value data was inserted');
      }).catchError((error) {
        print('[error] ${error.toString()}');
      });
      return Future(() => '');
    });
  }

  void getFromDatabase(database) {
    readLater = [];
    favorites = [];
    emit(AppDatabaseGetLoadingState());
    database.rawQuery('SELECT * FROM articles').then((List value) {
      value.forEach((element) {
        print(element);
        if (element['type'] == 'read later') {
          readLater?.add(element);
        }
        if (element['type'] == 'favorites') {
          favorites?.add(element);
        }
      });
      emit(AppDatabaseGetState());
    });
  }

  // updateInDatabase({required String status, required int id}) async {
  //   database.rawUpdate(
  //     'UPDATE tasks SET status = ? WHERE id = ?',
  //     ['$status', id],
  //   ).then((value) {
  //     getFromDatabase(database);
  //     emit(AppDatabaseUpdateState());
  //   });
  // }

  deleteFromDatabase({ int? id, String? type}) async {
    if(type!='no clear'){
      database.rawDelete(
        'DELETE FROM articles WHERE type = ?',
        [type],
      ).then((value) {
        getFromDatabase(database);
        emit(AppDatabaseClearState());
      });
    }else{
      database.rawDelete(
        'DELETE FROM articles WHERE id = ?',
        [id],
      ).then((value) {
        getFromDatabase(database);
        emit(AppDatabaseDeleteState());
      });
    }

  }

  // static Database? _db;
  // List<Map>? readLater = [];
  // List<Map>? favorites = [];
  // Future<Database?> get db async {
  //   print(await getDatabasesPath());
  //   if (_db == null) {
  //     _db = await initDb();
  //     print('[INFO] init ------------------------------');
  //     return _db;
  //   } else {
  //     print('[INFO] no init ------------------------------');
  //     return _db;
  //   }
  // }
  //
  // initDb() async {
  //   String pathToDatabase =
  //       await getDatabasesPath(); //get path to database folder
  //   String path =
  //       join(pathToDatabase, 'NewsDatabase.db'); //get path to app database file
  //   Database newsDb = await openDatabase(path,
  //       onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade); //open database
  //   return newsDb;
  // }
  //
  // _onUpgrade(db, oldVersion, newVersion) {
  //   print('[INFO] Upgrading database... (Done)');
  // }
  //
  // _onCreate(db, version) async {
  //   await db.execute();
  //   print('[INFO] database creation... (Done)');
  // }
  //
  // readData() async {
  //   readLater = [];
  //   favorites = [];
  //   Database? dataBase = await db;
  //   List<Map>? response = await dataBase!.rawQuery('SELECT * FROM articles').then((value) {
  //
  //     for (var element in value) {
  //       if(element['type'] == 'read later') {
  //         readLater?.add(element);
  //       }
  //       if(element['type'] == 'favorites') {
  //         favorites?.add(element);
  //       }
  //     }
  //   },);
  //   return response;
  // }
  //
  // updateData(query) async {
  //   Database? dataBase = await db;
  //   int response = await dataBase!.rawUpdate(query);
  //   return response;
  // }
  //
  // insertData(query) async {
  //   Database? dataBase = await db;
  //   int response = await dataBase!.rawInsert(query);
  //   return response;
  // }
  //
  // deleteData(query) async {
  //   Database? dataBase = await db;
  //   int response = await dataBase!.rawDelete(query);
  //   return response;
  // }
}
