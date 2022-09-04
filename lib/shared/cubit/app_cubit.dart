import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/network/local/cash_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      CashHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
  // var country = 'eg';
  // void changeCountry({String? country}) {
  //   if (country != null) {
  //     country = country;
  //     emit(AppChangeModeState());
  //   } else {
  //     country = !isDark;
  //     CashHelper.putBool(key: 'isDark', value: isDark).then((value) {
  //       emit(AppChangeModeState());
  //     });
  //   }
  // }

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

  deleteFromDatabase({int? id, String? type}) async {
    if (type != 'no clear') {
      database.rawDelete(
        'DELETE FROM articles WHERE type = ?',
        [type],
      ).then((value) {
        getFromDatabase(database);
        emit(AppDatabaseClearState());
      });
    } else {
      database.rawDelete(
        'DELETE FROM articles WHERE id = ?',
        [id],
      ).then((value) {
        getFromDatabase(database);
        emit(AppDatabaseDeleteState());
      });
    }
  }

  var localizationsDelegates = const [
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

}
