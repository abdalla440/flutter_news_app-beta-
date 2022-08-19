import 'package:flutter/material.dart';
import 'package:news_app/app.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/network/local/cash_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // make sure the await missions are done before run
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getData(key: 'isDark');
  runApp( NewsApp(isDark));

}
