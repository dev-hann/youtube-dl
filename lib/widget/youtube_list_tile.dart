import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/const/color.dart';
import 'package:youtube_dl/models/youtube.dart';
import 'package:youtube_dl/utils/format.dart';
import 'package:youtube_dl/widget/auto_slide_widget.dart';

abstract class YoutubeListTile<T extends Youtube> extends StatelessWidget {
  const YoutubeListTile({
    Key? key,
    required this.item,
    this.showDuration = true,
  }) : super(key: key);
  final T item;
  final bool showDuration;

  Widget? headPhoto();

  List<Shadow> _textBorder() {
    return const [
      Shadow(
        // bottomLeft
        offset: Offset(-1.5, -1.5),
        color: DlBlackColor,
      ),
      Shadow(
        // bottomRight
        offset: Offset(1.5, -1.5),
        color: DlBlackColor,
      ),
      Shadow(
        // topRight
        offset: Offset(1.5, 1.5),
        color: DlBlackColor,
      ),
      Shadow(
        // topLeft
        offset: Offset(-1.5, 1.5),
        color: DlBlackColor,
      ),
    ];
  }

  Widget duration() {
    if (!showDuration) return const SizedBox();
    return Text(
      Format.headPhotoDuration(item.duration),
      style: TextStyle(
        color: DlWhiteColor,
        shadows: _textBorder(),
      ),
    );
  }

  bool get titleAnimate;

  TextStyle get titleTextStyle => const TextStyle(color: DlWhiteColor);

  Widget title(String title) {
    return AutoSlideWidget(
      enable: titleAnimate,
      child: Text(
        title,
        maxLines: 1,
        style: titleTextStyle,
      ),
    );
  }

  bool get subTitleAnimate;

  Widget? subTitle(String subTitle) {
    return AutoSlideWidget(
      enable: subTitleAnimate,
      child: Text(
        subTitle,
        maxLines: 1,
        style: const TextStyle(color: DlGreyColor),
      ),
    );
  }

  Widget? trailing();

  double get horizontalTitleGap => 16.0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: headPhoto() == null
            ? null
            : Stack(
                alignment: Alignment.bottomRight,
                children: [
                  headPhoto()!,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: duration(),
                  ),
                ],
              ),
        horizontalTitleGap: horizontalTitleGap,
        title: title(item.title),
        subtitle: subTitle(item.description),
        trailing: trailing(),
      ),
    );
  }
}
