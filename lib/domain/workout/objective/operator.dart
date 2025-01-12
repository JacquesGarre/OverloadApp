class Operator {

  final String value;

  static const Operator add = Operator._('increase');
  static const Operator subtract = Operator._('subtract');
  static const Operator multiply = Operator._('multiply');
  static const Operator divide = Operator._('divide');

  const Operator._(this.value);

}