import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:just_audio/just_audio.dart';

import '../../../component/config/app_const.dart';
import '../../../component/config/app_route.dart';
import '../../../component/util/helper.dart';
import '../../../component/util/state.dart';
import '../model/list_surah_response.dart';
import '../repository/home_repository.dart';
import 'home_state.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;

  List<ListSurahResponse>? listSurah;
  List<ListSurahResponse> _allSurah = [];
  bool isLoading = true;
  HomeState state = HomeIdle();
  final TextEditingController searchController = TextEditingController();
  final Debouncer _searchDebouncer =
      Debouncer(delay: const Duration(milliseconds: 500));
  final player = AudioPlayer();
  // final Rx<ListSurahResponse?> lastAudio = ListSurahResponse().obs;
  final Rxn<ListSurahResponse> lastAudio = Rxn<ListSurahResponse>();

  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> position = Duration.zero.obs;
  RxBool isPlaying = false.obs;

  HomeController(this._repository);

  @override
  void onInit() {
    getListSurah();
    searchController.addListener(() {
      final query = searchController.text;
      _searchDebouncer(() {
        onSearchChanged(query);
      });
    });

    // addListener player
    player.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    player.durationStream.listen((newDuration) {
      if (newDuration != null) {
        duration.value = newDuration;
      }
    });

    player.positionStream.listen((pos) {
      position.value = pos;
    });

    super.onInit();
  }

  // @override
  // void onClose() async {
  //   await player.stop();
  //   await player.dispose();
  //   super.onClose();
  // }

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      listSurah = _allSurah;
    } else {
      listSurah = _allSurah
          .where((surah) =>
              surah.namaLatin!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    update();
  }

  String backgroundCard(String name) {
    switch (name) {
      case "madinah":
        return AppConst.assetImageElementaryLearn;
      default:
        return AppConst.assetImageBeginnerLearn;
    }
  }

  Future<void> getListSurah() async {
    isLoading = true;
    state = HomeLoading();
    _repository.getListSurah(
      response: ResponseHandler(onSuccess: (data) async {
        if (data.isNotEmpty) {
          state = HomeSuccess(data);
          listSurah = data;
          _allSurah = data;
        } else {
          state = HomeEmpty();
        }
      }, onFailed: (responseError, message) async {
        state = HomeError();

        AlertModel.showAlert(
          title: "Error",
          message: message,
        );
      }, onDone: () {
        isLoading = false;
        update();
      }),
    );
  }

  void toSurah({String namaLatin = '', int nomor = 0}) async {
    lastAudio.value = null;
    await player.stop();
    Get.toNamed(AppRoute.surah,
        arguments: {'title': namaLatin, 'surah_id': nomor});
  }

  void handleSlider(value) async {
    final pos = Duration(seconds: value.toInt());
    await player.seek(pos);

    resumeAudio(lastAudio.value);
  }
  // ========= controller audio

  void pauseAudio(ListSurahResponse? surah) async {
    try {
      await player.pause();
      surah?.audioCondition = "pause";
      update();
    } on PlayerException catch (e) {
      AlertModel.showAlert(
        title: "Error",
        message: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      AlertModel.showAlert(
        title: "Error",
        message: "Connection aborted: ${e.message.toString()}",
      );
    } catch (e) {
      AlertModel.showAlert(
        title: "Error",
        message: "An error occured: ${e.toString()}",
      );
    }
  }

  void stopAudio(ListSurahResponse? surah) async {
    try {
      lastAudio.value = null;
      await player.stop();
      surah?.audioCondition = "stop";
      update();
    } on PlayerException catch (e) {
      AlertModel.showAlert(
        title: "Error",
        message: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      AlertModel.showAlert(
        title: "Error",
        message: "Connection aborted: ${e.message.toString()}",
      );
    } catch (e) {
      AlertModel.showAlert(
        title: "Error",
        message: "An error occured: ${e.toString()}",
      );
    }
  }

  void resumeAudio(ListSurahResponse? surah) async {
    try {
      surah?.audioCondition = "playing";
      update();
      await player.play();
      surah?.audioCondition = "stop";
      update();
    } on PlayerException catch (e) {
      AlertModel.showAlert(
        title: "Error",
        message: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      AlertModel.showAlert(
        title: "Error",
        message: "Connection aborted: ${e.message.toString()}",
      );
    } catch (e) {
      AlertModel.showAlert(
        title: "Error",
        message: "An error occured: ${e.toString()}",
      );
    }
  }

  void playAudio(ListSurahResponse? surah) async {
    if (surah?.audio != null) {
      try {
        // ignore: prefer_conditional_assignment
        if (lastAudio.value == null) {
          lastAudio.value = surah;
          isPlaying.value = true;
        }
        lastAudio.value?.audioCondition = "stop";
        lastAudio.value = surah;
        isPlaying.value = true;
        lastAudio.value?.audioCondition = "stop";
        update();
        await player.stop();
        await player.setUrl(surah?.audio ?? '');
        surah?.audioCondition = "playing";
        update();
        await player.play();
        surah?.audioCondition = "stop";
        await player.stop();
        update();
      } on PlayerException catch (e) {
        AlertModel.showAlert(
          title: "Error",
          message: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        AlertModel.showAlert(
          title: "Error",
          message: "Connection aborted: ${e.message.toString()}",
        );
      } catch (e) {
        AlertModel.showAlert(
          title: "Error",
          message: "An error occured: ${e.toString()}",
        );
      }
    } else {
      AlertModel.showAlert(
        title: "Error",
        message: "Audio Not Found",
      );
    }
  }
}
