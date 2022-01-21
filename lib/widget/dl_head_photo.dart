import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_dl/models/youtube-dl.dart';

class DlHeadPhoto extends StatelessWidget {
  const DlHeadPhoto(
    this.dl, {
    Key? key,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  final YoutubeDl dl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  ImageProvider get imageProvider {
    print(dl.headPhotoPath);
    if (dl.headPhotoPath != null) {
      return FileImage(File(dl.headPhotoPath!));
    }
    return NetworkImage(dl.headPhoto);
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: imageProvider,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, st) {
        return const Text("imageError");
      },
    );
  }
}
