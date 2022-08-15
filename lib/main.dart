import 'package:flutter/material.dart';
import 'package:news_app/app.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const NewsApp());
  DioHelper.init();

}
