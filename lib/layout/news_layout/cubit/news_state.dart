part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsChangeBottomNavItemState extends NewsState {}

class NewsChangeScreenState extends NewsState {}

class NewsLoadingBusinessState extends NewsState {}

class NewsSuccessBusinessState extends NewsState {}

class NewsFailureBusinessState extends NewsState {}

class NewsLoadingSportsState extends NewsState {}

class NewsSuccessSportsState extends NewsState {}

class NewsFailureSportsState extends NewsState {}

class NewsLoadingScienceState extends NewsState {}

class NewsSuccessScienceState extends NewsState {}

class NewsFailureScienceState extends NewsState {}

class NewsLoadingHomeState extends NewsState {}

class NewsSuccessHomeState extends NewsState {}

class NewsFailureHomeState extends NewsState {}

class NewsLoadingSearchState extends NewsState {}

class NewsSuccessSearchState extends NewsState {}

class NewsFailureSearchState extends NewsState {}

class NewsLoadingHealthState extends NewsState {}

class NewsSuccessHealthState extends NewsState {}

class NewsFailureHealthState extends NewsState {}

class NewsLoadingTechnologyState extends NewsState {}

class NewsSuccessTechnologyState extends NewsState {}

class NewsFailureTechnologyState extends NewsState {}

class NewsLoadingHeadLinesState extends NewsState {}

class NewsSuccessHeadLinesState extends NewsState {}

class NewsFailureHeadLinesState extends NewsState {}
