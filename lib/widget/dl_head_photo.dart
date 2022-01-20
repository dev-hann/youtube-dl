import 'package:flutter/material.dart';

class DlHeadPhoto extends StatelessWidget {
  const DlHeadPhoto(
    String videoId, {
    Key? key,
    bool hq = false,
    this.width,
    this.height,
    this.fit,
  })  : _url = "https://img.youtube.com/vi/$videoId/" +
            (hq ? "hqdefault.jpg" : "default.jpg"),
        super(key: key);

  final String _url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      _url,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
