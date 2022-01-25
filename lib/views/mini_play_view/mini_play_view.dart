import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/views/mini_play_view/mini_player_list_tile.dart';
import 'mini_play_view_model.dart';

class MiniPlayView extends StatelessWidget {
  MiniPlayView({Key? key}) : super(key: key);

  final MiniPlayViewModel _viewModel = MiniPlayViewModel();

  Widget _progressBar() {
    return Obx(() {
      return LinearProgressIndicator(
        value: _viewModel.progress,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _progressBar(),
          MiniPlayListTile(
            dl: _viewModel.currentItem,
            playState: _viewModel.isPlaying,
            onTapPlay: _viewModel.onTapPlayButton,
            isListView: _viewModel.isPlayListView,
          ),
        ],
      );
    });
  }
}
