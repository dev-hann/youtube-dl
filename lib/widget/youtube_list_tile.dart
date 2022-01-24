import 'package:flutter/material.dart';
import 'package:youtube_dl/models/youtube.dart';

abstract class YoutubeListTile<T extends Youtube> extends StatelessWidget {
  const YoutubeListTile({
    Key? key,
    required this.item,
  }) : super(key: key);
  final T? item;

  Widget? headPhoto();

  Widget title(String title) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget subTitle(String subTitle) {
    return Text(
      subTitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget trailing();

  @override
  Widget build(BuildContext context) {
    if (item == null) return const SizedBox();
    return ListTile(
      leading: headPhoto(),
      title: title(item!.title),
      subtitle: subTitle(item!.description),
      trailing: trailing(),
    );
  }
}
