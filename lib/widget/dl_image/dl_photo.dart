import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_dl/models/youtube_dl.dart';

abstract class DlPhoto extends StatelessWidget {
  const DlPhoto({
    Key? key,
    required this.dl,
  }) : super(key: key);

  final YoutubeDl? dl;

  ImageProvider get imageProvider {
    if (dl!.headPhotoPath != null) {
      return FileImage(File(dl!.headPhotoPath!));
    }
    return NetworkImage(dl!.headPhoto);
  }

  Widget emptyView() {
    return const ColoredBox(
      color: Colors.black,
      child: SizedBox.expand(),
    );
  }

  Widget image();

  @override
  Widget build(BuildContext context) {
    if (dl == null) return emptyView();
    return image();
  }
}
