import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DownController extends GetxService {
  static DownController find() => Get.find<DownController>();

  late DownUseCase _useCase;

  void onReady() {
    super.onReady();
  }

  Future downAudio(String videoId) async {
    print("down$videoId");
  }
}

class DownUseCase {
  DownUseCase(this._repo);

  final DownRepo _repo;

  Future initUseCase() async {
    await _repo.initRepo();
  }

  Future downloadAudio(
      String videoId, ProgressCallback onReceiveProgress) async {
    await _repo.audio(videoId, onReceiveProgress);
  }
}

abstract class DownRepo {
  Future initRepo();

  Future audio(String videoId, ProgressCallback onReceiveProgress);
}
