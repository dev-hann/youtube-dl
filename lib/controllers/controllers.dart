import 'package:get/get.dart';

import 'src/download_controller.dart';
import 'src/play_controller.dart';
import 'src/play_list_controller.dart';

void initControllers() {
  Get.lazyPut(() => DownloadController());
  Get.lazyPut(() => PlayController());
  // Get.lazyPut(() => PlayListController());
}
