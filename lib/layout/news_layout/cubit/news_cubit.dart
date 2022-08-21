
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/Home/home_screen.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 2;
  List<BottomNavigationBarItem> navBarList = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center_rounded), label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball_rounded), label: 'Sport'),
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_rounded), label: 'Science'),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings_rounded), label: 'Settings'),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    HomeScreen(),
    ScienceScreen(),
    SettingsScreen()
  ];
  void onChangeSelectedIndex(int index) {
    currentIndex = index;
    switch (index) {
      case 0:
        {
          loadBusinessData();
        }
        break;
      case 1:
        {
          loadSportsData();
        }
        break;
      case 2:
        {
          loadHomeData();
        }
        break;
      case 3:
        {
          loadScienceData();
        }
        break;
    }
    emit(NewsChangeBottomNavItemState());
  }

  List<dynamic> businessData = [];

  /// create function to use when need to get Business data using getData method
  /// of [DioHelper] class
  void loadBusinessData() {
    if (businessData.isEmpty) {
      emit(NewsLoadingBusinessState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '03d124e4c62d41c2bbb263d9a256dd2f',
      })
          .then((value) => {
                emit(NewsSuccessBusinessState()),
                businessData = value.data['articles'],

              })
          .catchError((error) {
        emit(NewsFailureBusinessState());
        print(error.toString());
      });
    } else {
      emit(NewsSuccessBusinessState());
    }
  }

  List<dynamic> sportsData = [];

  /// create function to use when need to get Sports data using getData method
  /// of [DioHelper] class
  void loadSportsData() {
    if (sportsData.isEmpty) {
      emit(NewsLoadingSportsState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '03d124e4c62d41c2bbb263d9a256dd2f',
      })
          .then((value) => {
                emit(NewsSuccessSportsState()),
                sportsData = value.data['articles'],

              })
          .catchError((error) {
        emit(NewsFailureSportsState());
        print(error.toString());
      });
    } else {
      emit(NewsSuccessSportsState());
    }
  }

  List<dynamic> scienceData = [];

  /// create function to use when need to get Business data using getData method
  /// of [DioHelper] class
  void loadScienceData() {
    if (scienceData.isEmpty) {
      emit(NewsLoadingBusinessState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '03d124e4c62d41c2bbb263d9a256dd2f',
      })
          .then((value) => {
                emit(NewsSuccessBusinessState()),
                scienceData = value.data['articles'],

              })
          .catchError((error) {
        emit(NewsFailureBusinessState());
        print(error.toString());
      });
    } else {
      emit(NewsSuccessBusinessState());
    }
  }

  List<dynamic> homeData = [];

  /// create function to use when need to get Business data using getData method
  /// of [DioHelper] class
  void loadHomeData() {
    if (homeData.isEmpty) {
      emit(NewsLoadingBusinessState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'apiKey': '03d124e4c62d41c2bbb263d9a256dd2f',
      })
          .then((value) => {
                emit(NewsSuccessBusinessState()),
                homeData = value.data['articles'],
              })
          .catchError((error) {
        emit(NewsFailureBusinessState());
        print('there is an error: ----> ${error.toString()}');
      });
    } else {
      emit(NewsSuccessHomeState());
    }
  }

  List<dynamic> search = [];

  /// create function to use when need to get Business data using getData method
  /// of [DioHelper] class
  void loadSearchData({String? searchKey}) {
    search = [];
    if (search.isEmpty) {
      emit(NewsLoadingSearchState());
      DioHelper.getData(url: 'v2/everything', query: {
        'q':'$searchKey',
        'apiKey': '03d124e4c62d41c2bbb263d9a256dd2f',
      })
          .then((value) => {
        emit(NewsSuccessSearchState()),
        search = value.data['articles'],
      })
          .catchError((error) {
        emit(NewsFailureSearchState());
        print('there is an error: ----> ${error.toString()}');
      });
    } else {
      emit(NewsSuccessSearchState());
    }
  }
}
