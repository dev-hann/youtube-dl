import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_dl/models/youtube_dl.dart';

import '../dl_photo.dart';

class DlHeadPhoto extends DlPhoto {
  DlHeadPhoto(
    YoutubeDl dl, {
    this.width,
    this.height,
    this.fit,
  }) : super(key: ValueKey(dl.videoId), dl: dl);

  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget image() {
    return Image(
      image: imageProvider,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      errorBuilder: (_, __, st) {
        return const Text("imageError");
      },
    );
  }
}
