part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitialState extends AppState {}
class AppChangeModeState extends AppState{}
class AppChangeLanguageState extends AppState{}

class AppDatabaseCreateState extends AppState{}

class AppDatabaseInsertState extends AppState{}
class AppDatabaseGetLoadingState extends AppState{}
class AppDatabaseGetState extends AppState{}
class AppDatabaseUpdateState extends AppState{}
class AppDatabaseDeleteState extends AppState{}
class AppDatabaseClearState extends AppState{}
