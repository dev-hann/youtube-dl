import 'package:flutter/material.dart';
import 'package:youtube_dl/enums/download_state.dart';
import 'package:youtube_dl/models/download_snapshot.dart';
import 'package:youtube_dl/models/search_result.dart';
import 'package:youtube_dl/widget/youtube_list_tile.dart';

class SearchCardView extends YoutubeListTile<ResultItem> {
  const SearchCardView({
    Key? key,
    required ResultItem item,
    required this.snapshot,
    required this.onTapDown,
    required this.onTapPlay,
    required this.onTapStop,
  }) : super(key: key, item: item);
  final Function(ResultItem item) onTapDown;
  final Function(ResultItem item) onTapPlay;
  final Function(ResultItem item) onTapStop;
  final DownloadSnapshot snapshot;

  @override
  Widget trailing() {
    if (snapshot.state.isNone) {
      return GestureDetector(
        onTap: () {
          onTapDown(item);
        },
        child: const Icon(Icons.download),
      );
    } else if (snapshot.state.isDone) {
      return GestureDetector(
        onTap: () {
          onTapPlay(item);
        },
        child: const Icon(Icons.play_arrow),
      );
    } else {
      return GestureDetector(
        onTap: () {
          onTapStop(item);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: snapshot.progress,
            ),
            const Icon(Icons.stop)
          ],
        ),
      );
    }
  }

  @override
  Widget? subTitle(String subTitle) {
    if (!(snapshot.state.isNone || snapshot.state.isDone)) {
      subTitle = snapshot.state.toString();
    }
    return super.subTitle(subTitle);
  }

  @override
  Widget headPhoto() {
    return Image.network(item.headPhoto);
  }

  @override
  bool get subTitleAnimate => false;

  @override
  bool get titleAnimate => true;
}
