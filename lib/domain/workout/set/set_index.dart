class SetIndex {
  final int value;

  SetIndex({required this.value});

  bool equals(SetIndex index) {
    return value == index.value;
  }

  static SetIndex nextFromSetIndex(SetIndex? index) {
    if (index == null) {
      return SetIndex(value: 1);
    }
    return SetIndex(value: index.value+1);
  }

}