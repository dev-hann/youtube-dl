import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/widget/player_icons.dart';
import 'package:youtube_dl/widget/youtube_list_tile.dart';

class MiniPlayListTile extends YoutubeListTile<YoutubeDl> {
  const MiniPlayListTile({
    Key? key,
    required YoutubeDl? dl,
    required this.playState,
    required this.onTapPlay,
    required this.isListView,
  }) : super(key: key, item: dl);

  final bool playState;
  final VoidCallback onTapPlay;
  final bool isListView;

  @override
  Widget? headPhoto() {
    if (isListView) return null;
    return const Icon(Ionicons.list);
  }

  Widget _playBack() {
    return PlayerIcons.playBack();
  }

  Widget _playForward() {
    return PlayerIcons.playForward();
  }

  Widget _play() {
    return PlayerIcons.playPause(
      state: playState,
      onTap: onTapPlay,
    );
  }

  @override
  Widget trailing() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _playBack(),
        _play(),
        _playForward(),
      ],
    );
  }
}
