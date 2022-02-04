import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/widget/player_icons.dart';
import 'package:youtube_dl/widget/youtube_list_tile.dart';

class MiniPlayListTile extends YoutubeListTile<YoutubeDl> {
  const MiniPlayListTile({
    Key? key,
    required YoutubeDl dl,
    required this.playState,
    required this.onTapPlay,
    required this.onTapListView,
    required this.onTapForward,
    required this.onTapBackward,
    this.background,
  }) : super(
          key: key,
          item: dl,
          showDuration: false,
        );

  final bool playState;
  final VoidCallback onTapPlay;
  final VoidCallback onTapListView;
  final VoidCallback onTapForward;
  final VoidCallback onTapBackward;
  final Color? background;

  @override
  Widget? headPhoto() {
    return IconTheme(
      data: Get.theme.iconTheme,
      child: PlayerIcons.playList(
        onTap: onTapListView,
      ),
    );
  }

  Widget _playBack() {
    return PlayerIcons.playBack(
      onTap: onTapBackward,
    );
  }

  Widget _playForward() {
    return PlayerIcons.playForward(
      onTap: onTapForward,
    );
  }

  Widget _play() {
    return PlayerIcons.playPause(
      state: playState,
      onTap: onTapPlay,
    );
  }

  @override
  Widget trailing() {
    return IconTheme(
      data: Get.theme.iconTheme,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _playBack(),
          _play(),
          _playForward(),
        ],
      ),
    );
  }

  @override
  Widget? subTitle(String subTitle) {
    return null;
  }

  @override
  bool get subTitleAnimate => true;

  @override
  bool get titleAnimate => true;

  @override
  // TODO: implement horizontalTitleGap
  double get horizontalTitleGap => 0.0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: background ?? Colors.black.withOpacity(.8),
      child: SizedBox(
        height: kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: super.build(context),
        ),
      ),
    );
  }
}
