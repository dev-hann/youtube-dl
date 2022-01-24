import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
      ),
    );
  }

  static Widget playBack({VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Ionicons.play_back),
    );
  }

  static Widget playForward({VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Ionicons.play_forward),
    );
  }
}

const _animationDuration = Duration(milliseconds: 300);

class _AnimationIcon extends StatefulWidget {
  const _AnimationIcon({
    Key? key,
    required this.animatedIcons,
    required this.state,
  }) : super(key: key);

  final AnimatedIconData animatedIcons;
  final bool state;

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
    );
  }
}
