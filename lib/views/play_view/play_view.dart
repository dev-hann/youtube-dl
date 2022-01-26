import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:youtube_dl/widget/dl_head_photo.dart';
import 'package:youtube_dl/widget/player_icons.dart';

import 'play_view_model.dart';

class PlayView extends StatefulWidget {
  const PlayView({Key? key}) : super(key: key);

  @override
  _PlayViewState createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView> {
  final PlayViewModel _viewModel = PlayViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget headPhotoListView() {
    return Obx(() {
      return CarouselSlider.builder(
        carouselController: _viewModel.pageController,
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
    return Obx(() {
      return Text(
        _viewModel.title,
        maxLines: 1,
      );
    });
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
    return Obx(() {
      if (_viewModel.isLoading) return SizedBox();
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
    });
  }
}
