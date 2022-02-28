import 'package:get/get.dart';

import 'src/youtube_controller.dart';
import 'src/audio_controller.dart';

void initControllers() {
  Get.lazyPut(() => YoutubeController());
  Get.lazyPut(() => AudioController());
}
