import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/network/local/cash_helper.dart';
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
}
