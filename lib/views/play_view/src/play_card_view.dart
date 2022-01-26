import 'package:flutter/material.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/widget/dl_head_photo.dart';
import 'package:youtube_dl/widget/youtube_list_tile.dart';

class PlayCardView extends YoutubeListTile<YoutubeDl> {
  const PlayCardView({
    Key? key,
    required YoutubeDl item,
    required this.onTapPlay,
  }) : super(key: key, item: item);
  final Function(YoutubeDl item) onTapPlay;

  @override
  Widget headPhoto() {
    return DlHeadPhoto(item!);
  }

  @override
  Widget trailing() {
    return const SizedBox();
  }
}
