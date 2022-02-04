import 'package:flutter/material.dart';

class AutoSlideWidget extends StatefulWidget {
  const AutoSlideWidget({
    Key? key,
    this.scrollDirection = Axis.horizontal,
    this.speed = 50,
    this.enable = true,
    required this.child,
  }) : super(key: key);
  final Axis scrollDirection;
  final Text child;
  final int speed;
  final bool enable;

  @override
  _AutoSlideWidgetState createState() => _AutoSlideWidgetState();
}

class _AutoSlideWidgetState extends State<AutoSlideWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.enable) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        final maxWidth = computeTextWidth();
        _animationController = AnimationController(
          vsync: this,
          duration:
              Duration(milliseconds: maxWidth.toInt() * 13 * widget.speed),
        );
        _animationController.addListener(_listener);
        Future.delayed(const Duration(seconds: 1)).then((value) {
          _animationController.forward();
        });
      });
    }
  }

  double computeTextWidth() {
    TextPainter _tp = TextPainter(
      text: TextSpan(text: widget.child.data),
      textDirection: TextDirection.ltr,
    );
    _tp.layout();
    return _tp.width;
  }

  void _listener() {
    final value = _animationController.value;
    _scrollController
        .jumpTo(value * _scrollController.position.maxScrollExtent);
    setState(() {});
    if (_animationController.isCompleted) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    if (widget.enable) {
      _animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enable) return widget.child;
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: widget.scrollDirection,
      child: Row(
        children: List.filled(
            10,
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: widget.child,
            )),
      ),
    );
  }
}
