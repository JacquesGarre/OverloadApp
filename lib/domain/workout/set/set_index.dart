class SetIndex {
  final int _value;

  SetIndex({required int value}) : _value = value;

  bool equals(SetIndex index) {
    return _value == index.value();
  }

  int value() {
    return _value;
  }

  static SetIndex nextFromSetIndex(SetIndex? index) {
    if (index == null) {
      return SetIndex(value: 1);
    }
    return SetIndex(value: index.value() + 1);
  }
}
