class SetIndex {
  final int value;

  SetIndex({required this.value});

  bool equals(SetIndex index) {
    return value == index.value;
  }
}