import 'package:flutter/material.dart';
import 'package:youtube_dl/models/search_result.dart';
import 'package:ionicons/ionicons.dart';
import 'package:youtube_dl/widget/youtube_list_tile.dart';

import '../../../widget/dl_head_photo.dart';

class SearchCardView extends YoutubeListTile<ResultItem> {
  const SearchCardView({
    Key? key,
    required ResultItem item,
    required this.onTapDown,
    required this.onTapPlay,
    required this.onTapStop,
    required this.progress,
  }) : super(key: key, item: item);
  final Function(ResultItem item) onTapDown;
  final Function(ResultItem item) onTapPlay;
  final Function(ResultItem item) onTapStop;
  final double? progress;

  @override
  Widget trailing() {
    if (progress == null) {
      return IconButton(
        onPressed: () {
          onTapDown(item!);
        },
        icon: const Icon(
          Ionicons.download,
        ),
      );
    } else if (progress == 1) {
      return IconButton(
        onPressed: () {
          onTapPlay(item!);
        },
        icon: const Icon(Ionicons.play),
      );
    } else {
      return GestureDetector(
        onTap: () {
          onTapStop(item!);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: progress,
            ),
            const Icon(Ionicons.stop)
          ],
        ),
      );
    }
  }

  @override
  Widget headPhoto() {
    return Image.network(item!.headPhoto);
  }
}
