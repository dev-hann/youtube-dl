import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:youtube_dl/models/youtube-dl.dart';
import 'package:youtube_dl/widget/dl_head_photo.dart';

class PlayCardView extends StatelessWidget {
  const PlayCardView({
    Key? key,
    required this.item,
    required this.onTapPlay,
  }) : super(key: key);
  final YoutubeDl item;
  final Function(YoutubeDl item) onTapPlay;

  Widget _headPhoto() {
    return DlHeadPhoto(item.videoId);
  }

  Widget _title() {
    return Text(
      item.title ?? "",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _trailing() {
    return IconButton(
      onPressed: () {
        onTapPlay(item);
      },
      icon: const Icon(Ionicons.play),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: _headPhoto(),
        title: _title(),
        trailing: _trailing(),
      ),
    );
  }
}
