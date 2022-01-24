import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:youtube_dl/views/play_view/src/play_card_view.dart';
import 'package:youtube_dl/widget/dl_head_photo.dart';
import 'package:youtube_dl/widget/player_icons.dart';

import 'play_view_model.dart';

class PlayView extends StatelessWidget {
  PlayView({Key? key}) : super(key: key);
  final PlayViewModel _viewModel = PlayViewModel();

  //
  // Widget _listView() {
  //   return Obx(() {
  //     if (_viewModel.isLoading) {
  //       return const Center(child: CircularProgressIndicator());
  //     }
  //     return ListView.builder(
  //       itemCount: _viewModel.dlList.length,
  //       itemBuilder: (_, index) {
  //         return Dismissible(
  //           direction: DismissDirection.endToStart,
  //           onDismissed: (direction) {
  //             print(direction);
  //             _viewModel.removeItem(index);
  //           },
  //           background: const ColoredBox(
  //             color: Colors.red,
  //             child: Padding(
  //               padding: EdgeInsets.all(8.0),
  //               child: Align(
  //                 alignment: Alignment.centerRight,
  //                 child: Text(
  //                   "Delete",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           key: ValueKey(index),
  //           child: PlayCardView(
  //             item: _viewModel.dlList[index],
  //             onTapPlay: _viewModel.onSelectItem,
  //           ),
  //         );
  //       },
  //     );
  //   });
  // }
  //
  // Widget _progressBar() {
  //   return Obx(() {
  //     return Row(
  //       children: [
  //         Text(_viewModel.currentDurationText),
  //         Expanded(
  //           child: Slider(
  //             value: _viewModel.progress,
  //             onChangeStart: _viewModel.onStartSeek,
  //             onChanged: _viewModel.onChangeSeek,
  //             onChangeEnd: _viewModel.onEndSeek,
  //           ),
  //         ),
  //         Text(_viewModel.totalDurationText),
  //       ],
  //     );
  //   });
  // }
  //
  // Widget _controlButtons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       IconButton(
  //         onPressed: () {},
  //         icon: const Icon(Ionicons.play_back),
  //       ),
  //       IconButton(
  //         onPressed: _viewModel.onTapPlay,
  //         icon: const Icon(Ionicons.play),
  //       ),
  //       IconButton(
  //         onPressed: _viewModel.onTapPause,
  //         icon: const Icon(Ionicons.pause),
  //       ),
  //       IconButton(
  //         onPressed: () {},
  //         icon: const Icon(Ionicons.play_forward),
  //       )
  //     ],
  //   );
  // }

  Widget headPhotoListView() {
    return Obx(() {
      return CarouselSlider.builder(
        carouselController: _viewModel.controller,
        itemCount: _viewModel.dlList.length,
        itemBuilder: (_, index, __) {
          return DlHeadPhoto(
            _viewModel.dlList[index],
            fit: BoxFit.fitWidth,
          );
        },
        options: CarouselOptions(
          scrollPhysics: const BouncingScrollPhysics(),
          viewportFraction: 0.7,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          onPageChanged: _viewModel.onChangedPage,
        ),
      );
    });
  }

  Widget title() {
    return const Text("Title");
  }

  Widget _progressBar() {
    Widget _slider() {
      return Slider(
        value: _viewModel.progress,
        onChangeStart: _viewModel.onStartSeek,
        onChanged: _viewModel.onChangeSeek,
        onChangeEnd: _viewModel.onEndSeek,
      );
    }

    Widget _position() {
      return Text(_viewModel.positionText);
    }

    Widget _duration() {
      return Text(_viewModel.durationText);
    }

    return Obx(() {
      return Row(
        children: [
          _position(),
          Expanded(child: _slider()),
          _duration(),
        ],
      );
    });
  }

  Widget _buttons() {
    Widget _playBack() {
      return Icon(Ionicons.play_back);
    }

    Widget _play() {
      return GestureDetector(
        onTap: _viewModel.onTapPlay,
        child: Obx(() {
          return PlayerIcons.playPause(
            state: _viewModel.isPlaying,
          );
        }),
      );
    }

    Widget _playForward() {
      return Icon(Ionicons.play_forward);
    }

    Widget _list() {
      return IconButton(
        onPressed: _viewModel.onTapPlayList,
        icon: const Icon(Ionicons.list),
      );
    }

    Widget _mode() {
      return Icon(Ionicons.invert_mode);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _mode(),
        _playBack(),
        _play(),
        _playForward(),
        _list(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          headPhotoListView(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: title(),
          ),
          SizedBox(height: Get.height / 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _progressBar(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buttons(),
          ),
        ],
      ),
    );
  }
}
