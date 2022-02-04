import 'package:flutter/material.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/widget/dl_image/src/dl_head_photo.dart';
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
    return DlHeadPhoto(item);
  }

  @override
  Widget? subTitle(String subTitle) {
    return null;
  }

  @override
  Widget trailing() {
    return const SizedBox();
  }

  @override
  // TODO: implement subTitleAnimate
  bool get subTitleAnimate => false;

  @override
  // TODO: implement titleAnimate
  bool get titleAnimate => false;

}
