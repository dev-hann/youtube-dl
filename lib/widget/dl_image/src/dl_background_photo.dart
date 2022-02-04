import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:youtube_dl/const/color.dart';
import 'package:youtube_dl/models/youtube_dl.dart';

import '../dl_photo.dart';

class DlBackgroundPhoto extends DlPhoto {
  const DlBackgroundPhoto({
    Key? key,
    this.blur = 20,
    this.heightFactor = 1.0,
    required YoutubeDl? dl,
    required this.child,
  }) : super(
          key: key,
          dl: dl,
        );
  final Widget child;
  final double blur;
  final double heightFactor;

  @override
  Widget emptyView() {
    return Material(
      child: Stack(
        children: [
          super.emptyView(),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 50,
              sigmaY: 50,
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  Widget image() {
    return Material(
      child: Stack(
        children: [
          Align(
            heightFactor: heightFactor,
            child: Transform.scale(
              scale: 2,
              alignment: Alignment.center,
              child: Image(
                image: imageProvider,
                fit: BoxFit.cover,
                height: double.infinity,
                color: DlBlackColor.withOpacity(.5),
                colorBlendMode: BlendMode.srcATop,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blur,
              sigmaY: blur,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
