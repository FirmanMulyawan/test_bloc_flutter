import '../model/list_surah_response.dart';

abstract class HomeState {}

class HomeSuccess extends HomeState {
  final List<ListSurahResponse> list;
  HomeSuccess(this.list);
}

class HomeLoading extends HomeState {}

class HomeIdle extends HomeState {}

class HomeError extends HomeState {}

class HomeEmpty extends HomeState {}
