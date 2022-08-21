import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:news_app/layout/news_layout/news_layout.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';

class NewsApp extends StatelessWidget {
  final bool? isDark;
  NewsApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => AppCubit()..changeMode(themeIndicator: isDark),
),
    BlocProvider(
      create: (context) =>  NewsCubit()..loadHomeData(),
    ),
  ],
  child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder:(context, state) {
          return MaterialApp(
            home: const NewsHome(),
            theme: ThemeData(
                primarySwatch: Colors.teal,
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.white),
                  color: Colors.white,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                  actionsIconTheme: IconThemeData(
                    color: Colors.black,
                    size: 25.0,
                  ),
                  elevation: 0.5,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    elevation: 20,
                    backgroundColor: Colors.white,
                    unselectedItemColor: Colors.grey[500],
                    selectedItemColor: Colors.grey[850],
                    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500)),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black))),
            darkTheme: ThemeData(
                primarySwatch: Colors.teal,
                appBarTheme: AppBarTheme(
                  backgroundColor: HexColor('333739'),
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light,
                      statusBarColor: HexColor('333739')),
                  titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0),
                  actionsIconTheme: const IconThemeData(
                    color: Colors.white,
                    size: 25.0,
                  ),
                  elevation: 0.5,
                ),
                scaffoldBackgroundColor: HexColor('333739'),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    elevation: 20,
                    backgroundColor: HexColor('333739'),
                    unselectedItemColor: Colors.grey[500],
                    selectedItemColor: Colors.teal[500],
                    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500)),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white))),
            themeMode: AppCubit.get(context).isDark? ThemeMode.dark :ThemeMode.light,
            debugShowCheckedModeBanner: false,
          );
        },

      ),
);
  }
}
