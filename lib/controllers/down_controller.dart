import 'package:get/get.dart';

class DownController extends GetxService {
  static DownController find() => Get.find<DownController>();

  Future downAudio(String videoId) async {
    print("down$videoId");
  }
}
