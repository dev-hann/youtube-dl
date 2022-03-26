import 'package:get/get.dart';

import 'src/home_controller.dart';
import 'src/youtube_controller.dart';
import 'src/audio_controller.dart';

void initControllers() {
  Get.put(HomeController());

  Get.lazyPut(() => YoutubeController());
  Get.lazyPut(() => AudioController());
}
