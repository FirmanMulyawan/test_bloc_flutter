import '../model/surah_by_id_response.dart';

abstract class SurahState {}

class SurahSuccess extends SurahState {
  final SurahByIdResponse? data;
  SurahSuccess(this.data);
}

class SurahLoading extends SurahState {}

class SurahIdle extends SurahState {}

class SurahError extends SurahState {}

class SurahEmpty extends SurahState {}
