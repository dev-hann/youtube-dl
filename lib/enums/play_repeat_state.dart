enum PlayRepeatState {
  none,
  one,
  all,
  // group,
}


extension PlayRepeatStateExtension on PlayRepeatState{
  bool get isNone=> this==PlayRepeatState.none;
  bool get isOne=> this==PlayRepeatState.one;
  bool get isAll=> this==PlayRepeatState.all;
  // bool get isGroup=> this==PlayRepeatState.group;
}


