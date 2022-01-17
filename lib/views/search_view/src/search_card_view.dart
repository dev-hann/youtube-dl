import 'package:flutter/material.dart';
import 'package:youtube_dl/models/search_result.dart';
import 'package:ionicons/ionicons.dart';

import 'search_head_photo.dart';

class SearchCardView extends StatelessWidget {
  const SearchCardView({
    Key? key,
    required this.item,
    required this.onTapDown,
    required this.onTapPlay,
    required this.onTapStop,
    required this.progress,
  }) : super(key: key);
  final ResultItem item;
  final Function(ResultItem item) onTapDown;
  final Function(ResultItem item) onTapPlay;
  final Function(ResultItem item) onTapStop;
  final double? progress;

  Widget _trailing() {
    if (progress == null) {
      return IconButton(
        onPressed: () {
          onTapDown(item);
        },
        icon: const Icon(
          Ionicons.download,
        ),
      );
    } else if (progress == 1) {
      return IconButton(
        onPressed: () {
          onTapPlay(item);
        },
        icon: const Icon(Ionicons.play),
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
              value: progress,
            ),
            const Icon(Ionicons.stop)
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SearchHeadPhoto(item.videoId),
        title: Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          item.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: _trailing(),
      ),
    );
  }
}
