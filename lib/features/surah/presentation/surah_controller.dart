import 'package:get/get.dart';

import '../../../component/util/helper.dart';
import '../../../component/util/state.dart';
import '../model/surah_by_id_response.dart';
import '../repository/surah_repository.dart';
import 'surah_state.dart';

class SurahController extends GetxController {
  final SurahRepository _repository;
  bool isLoading = true;
  SurahState state = SurahIdle();
  final RxString title = ''.obs;
  final RxInt surahId = 0.obs;
  final Rx<SurahByIdResponse?> surahIdResponse = SurahByIdResponse().obs;

  SurahController(this._repository);

  @override
  void onInit() {
    super.onInit();
    title.value = Get.arguments['title'];
    surahId.value = Get.arguments['surah_id'];

    getSurah();
  }

  Future<void> getSurah() async {
    isLoading = true;
    state = SurahLoading();
    _repository.getListSurah(
        nomor: surahId.value,
        response: ResponseHandler(onSuccess: (data) async {
          surahIdResponse.value = data;
        }, onFailed: (responseError, message) async {
          state = SurahError();

          AlertModel.showAlert(
            title: "Error",
            message: message,
          );
        }, onDone: () {
          isLoading = false;
          update();
        }));
  }

  void nextAyat({String isTitle = '', int isSurahId = 0}) {
    title.value = isTitle;
    surahId.value = isSurahId;
    getSurah();
  }
}
