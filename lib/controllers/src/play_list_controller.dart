// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:get/get.dart';
// import 'package:youtube_dl/models/play_list.dart';
// import 'package:youtube_dl/models/youtube_dl.dart';
// import 'package:youtube_dl/repos/play_list_repo/src/play_list_impl.dart';
// import 'package:youtube_dl/use_cases/play_list_use_case/play_list_use_case.dart';
//
// class PlayListController extends GetxService {
//   static PlayListController find() => Get.find<PlayListController>();
//
//   late Rx<PlayList> _playList;
//
//   PlayList get playList => _playList.value;
//
//   @override
//   void onReady() {
//     _initPLayList();
//     super.onReady();
//   }
//
//   final RxBool _loading = true.obs;
//
//   bool get isLoading => _loading.value;
//
//   late PlayListUseCase _useCase;
//
//   Future _initPLayList() async {
//     _useCase = PlayListUseCase(PlayListImpl());
//     await _useCase.initUseCase();
//     _playList = _useCase.loadPlayList().obs;
//     _loading(false);
//   }
//
//   Future updatePlayList(PlayList newPlayList) async {
//     await _useCase.updatePlayList(newPlayList);
//     _playList(newPlayList);
//   }
//
//   Future reorderPlayList(int oldIndex, int newIndex) async {
//     _playList.update((val) {
//       final item = val!.videoIdList.removeAt(oldIndex);
//       val.videoIdList.insert(newIndex, item);
//     });
//     await _useCase.updatePlayList(playList);
//   }
//
//   Future addItem(String videoId) async {
//     if (playList.videoIdList.contains(videoId)) return;
//     _playList.value.videoIdList.add(videoId);
//     await _useCase.updatePlayList(playList);
//     _playList.refresh();
//   }
//
//   Future removeItem(String videoId) async {
//     playList.videoIdList.remove(videoId);
//     await _useCase.updatePlayList(playList);
//   }
//
//   /// playView
//   final CarouselControllerImpl pageController = CarouselControllerImpl();
//
//   void refreshCurrentPage(
//     bool isPlaying,
//     YoutubeDl? currentItem,
//   ) {
//     if (!isPlaying) {
//       pageController.jumpToPage(0);
//       return;
//     }
//     final index = playList.videoIdList
//         .indexWhere((element) => element == currentItem!.videoId);
//     if (index == -1) return;
//
//     pageController.jumpToPage(index);
//   }
// }
