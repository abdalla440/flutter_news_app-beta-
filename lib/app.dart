import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:news_app/layout/news_layout/news_layout.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/news_layout_temp.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';

class NewsApp extends StatelessWidget {
  final bool? isDark;
  NewsApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..changeMode(themeIndicator: isDark)
            ..createDatabase(),
        ),
        BlocProvider(
          create: (context) => NewsCubit()..loadHomeData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              home: const NewsLayoutTemp(),
              theme: ThemeData(
                  primarySwatch: Colors.red,
                  appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.black),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.dark,
                        statusBarColor: Colors.red),
                    color: Colors.red,
                    titleTextStyle: TextStyle(
                        color: Colors.white,
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
                      selectedItemColor: Colors.red,
                      selectedLabelStyle:
                          const TextStyle(fontWeight: FontWeight.w500)),
                  tabBarTheme: TabBarTheme(
                    labelColor: Colors.black.withOpacity(0.9),
                    unselectedLabelColor: Colors.black.withOpacity(0.5),
                  ),
                  textTheme: const TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      bodyText2:
                          TextStyle(fontSize: 18.0, color: Colors.black)),
                  iconTheme: const IconThemeData(color: Colors.black)),
              darkTheme: ThemeData(
                  primarySwatch: Colors.red,
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.white.withOpacity(0.12),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.light,
                        statusBarColor: Colors.white.withOpacity(0.12)),
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
                  scaffoldBackgroundColor: HexColor('121212'),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      elevation: 20,
                      backgroundColor: Colors.white.withOpacity(0.12),
                      unselectedItemColor: Colors.grey[500],
                      selectedItemColor: Colors.red[500],
                      selectedLabelStyle:
                          const TextStyle(fontWeight: FontWeight.w500)),
                  tabBarTheme: TabBarTheme(
                    labelColor: Colors.white.withOpacity(0.9),
                    unselectedLabelColor: Colors.white.withOpacity(0.5),
                  ),
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    bodyText2: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  iconTheme: const IconThemeData(color: Colors.white)),
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppCubit.get(context).localizationsDelegates,
              supportedLocales: const [
                Locale(
                    "en", "US"),
                Locale(
                    "ar", "EG"),
              ],
              locale: const Locale("en", "US"));
        },
      ),
    );
  }
}
