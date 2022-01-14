
import 'package:get/get.dart';
import 'package:youtube_dl/controllers/src/down_controller.dart';

void initControllers(){
  Get.lazyPut(() => DownController());
}