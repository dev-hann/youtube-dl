import 'package:flutter/material.dart';
import 'package:youtube_dl/const/color.dart';
import 'package:youtube_dl/models/youtube_dl.dart';
import 'package:youtube_dl/widget/dl_image/src/dl_head_photo.dart';
import 'package:youtube_dl/widget/youtube_list_tile.dart';

class PlayCardView extends YoutubeListTile<YoutubeDl> {
  const PlayCardView({
    Key? key,
    required YoutubeDl item,
    required this.isPlaying,
    required this.onTapMore,
  }) : super(key: key, item: item);
  final bool isPlaying;
  final Function(YoutubeDl item) onTapMore;

  @override
  Widget headPhoto() {
    return DlHeadPhoto(item);
  }

  @override
  TextStyle get titleTextStyle => TextStyle(
        color: isPlaying ? DlGreenColor : DlWhiteColor,
      );

  @override
  Widget? subTitle(String subTitle) {
    return null;
  }

  @override
  Widget trailing() {
    return GestureDetector(
      onTap: (){
        onTapMore(item);
      },
      child: const Icon(Icons.more_vert),
    );
  }

  @override
  // TODO: implement subTitleAnimate
  bool get subTitleAnimate => false;

  @override
  // TODO: implement titleAnimate
  bool get titleAnimate => false;
}
