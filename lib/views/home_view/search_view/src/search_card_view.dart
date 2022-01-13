import 'package:flutter/material.dart';
import 'package:youtube_dl/models/search_result.dart';
import 'package:youtube_dl/views/home_view/search_view/src/search_head_photo.dart';
import 'package:ionicons/ionicons.dart';

class SearchCardView extends StatelessWidget {
  const SearchCardView({
    Key? key,
    required this.item,
    required this.onTapDown,
  }) : super(key: key);
  final ResultItem item;
  final Function(String videoId) onTapDown;

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
        trailing: IconButton(
          onPressed: () {
            onTapDown(item.videoId);
          },
          icon: const Icon(
            Ionicons.download,
          ),
        ),
      ),
    );
  }
}
