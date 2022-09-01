

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/Home/home_screen.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/headlines/headlines_screen.dart';
import 'package:news_app/modules/health/health_screen.dart';
import 'package:news_app/modules/profile/profile_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/modules/technology/technology_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentNavBarIndex = 0;
  int currentTabBarIndex = 0;
  String appBarTitle = 'News App';
  List<BottomNavigationBarItem> navBarList = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_rounded),label:'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.newspaper_rounded),label:'Headlines'),
    BottomNavigationBarItem(
        icon: Icon(Icons.search_rounded),label:'search'),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_rounded),label:'Customs'),

  ];
  List<Widget> screens = [
    HomeScreen(),
    HeadLinesScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];
  List<Widget> homeTabsBody = [
    BusinessScreen(),
    ScienceScreen(),
    HealthScreen(),
    TechnologyScreen(),
    SportsScreen(),
  ];
  List<Widget> homeTabsLabel =[
    Text('Business'),
    Text('Science'),
    Text('health'),
    Text('technology'),
    Text('Sport'),
  ];
  void onChangeSelectedIndex(int index) {
    currentNavBarIndex = index;
    if(index == 3){
      appBarTitle = 'My Profile';
    }
    else{
      appBarTitle = 'News App';

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
        'apiKey': '5d22678c239242eea6529d3224b90299',
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
        'apiKey': '5d22678c239242eea6529d3224b90299',
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
        'apiKey': '5d22678c239242eea6529d3224b90299',
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
        'apiKey': '5d22678c239242eea6529d3224b90299',
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
        'apiKey': '5d22678c239242eea6529d3224b90299',
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

  List<dynamic> healthData = [];

  /// create function to use when need to get Business data using getData method
  /// of [DioHelper] class
  void loadHealthData() {
    if (healthData.isEmpty) {
      emit(NewsLoadingHealthState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'health',
        'apiKey': '5d22678c239242eea6529d3224b90299',
      })
          .then((value) => {
        emit(NewsSuccessHealthState()),
        healthData = value.data['articles'],

      })
          .catchError((error) {
        emit(NewsFailureHealthState());
        print(error.toString());
      });
    } else {
      emit(NewsSuccessBusinessState());
    }
  }

  List<dynamic> technologyData = [];

  /// create function to use when need to get Business data using getData method
  /// of [DioHelper] class
  void loadTechnologyData() {
    if (technologyData.isEmpty) {
      emit(NewsLoadingTechnologyState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'technology',
        'apiKey': '5d22678c239242eea6529d3224b90299',
      })
          .then((value) => {
        emit(NewsSuccessTechnologyState()),
        technologyData = value.data['articles'],

      })
          .catchError((error) {
        emit(NewsFailureTechnologyState());
        print(error.toString());
      });
    } else {
      emit(NewsSuccessBusinessState());
    }
  }

  List<dynamic> headLiensData = [];

  /// create function to use when need to get Business data using getData method
  /// of [DioHelper] class
  void loadHeadlinesData() {
    if (headLiensData.isEmpty) {
      emit(NewsLoadingHeadLinesState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'apiKey': '5d22678c239242eea6529d3224b90299',
      })
          .then((value) => {
        emit(NewsSuccessHeadLinesState()),
        headLiensData = value.data['articles'],

      })
          .catchError((error) {
        emit(NewsFailureHeadLinesState());
        print(error.toString());
      });
    } else {
      emit(NewsSuccessBusinessState());
    }
  }

  void createDatabase(){

  }
}
