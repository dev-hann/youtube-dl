import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_dl/const/color.dart';
import 'package:youtube_dl/enums/play_repeat_state.dart';

class PlayerIcons {
  static Widget playPause({
    required bool state,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: _AnimationIcon(
        animatedIcons: AnimatedIcons.play_pause,
        state: state,
        size: 36,
      ),
    );
  }

  static Widget playBack({VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.fast_rewind,
        size: 36,
      ),
    );
  }

  static Widget playForward({VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.fast_forward,
        size: 36,
      ),
    );
  }

  static Widget playList({VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.list,
        size: 36,
      ),
    );
  }

  static Widget playRepeat({
    VoidCallback? onTap,
    required PlayRepeatState state,
  }) {
    late Icon _icon;
    switch (state) {
      case PlayRepeatState.one:
        _icon = const Icon(Icons.repeat_one);
        break;
      case PlayRepeatState.none:
        _icon = const Icon(
          Icons.repeat,
          color: DlGreyColor,
        );
        break;
      case PlayRepeatState.all:
        _icon = const Icon(Icons.repeat);
        break;
      // case PlayRepeatState.group:
      //   _icon = const Icon(Icons.group);
      //   break;
    }
    return GestureDetector(
      onTap: onTap,
      child: IconTheme(
        data: Get.theme.iconTheme.copyWith(size: 36),
        child: _icon,
      ),
    );
  }
}

const _animationDuration = Duration(milliseconds: 300);

class _AnimationIcon extends StatefulWidget {
  const _AnimationIcon({
    Key? key,
    this.size = 24.0,
    required this.animatedIcons,
    required this.state,
  }) : super(key: key);

  final AnimatedIconData animatedIcons;
  final bool state;
  final double size;

  @override
  __AnimationIconState createState() => __AnimationIconState();
}

class __AnimationIconState extends State<_AnimationIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    controller.addListener(listener);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _updateState(widget.state);
    });
  }

  @override
  void didUpdateWidget(_AnimationIcon oldWidget) {
    _updateState(widget.state);
    super.didUpdateWidget(oldWidget);
  }

  void listener() {
    setState(() {});
  }

  void _updateState(bool value) {
    if (value) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIcon(
      icon: widget.animatedIcons,
      progress: controller,
      size: widget.size,
    );
  }
}
