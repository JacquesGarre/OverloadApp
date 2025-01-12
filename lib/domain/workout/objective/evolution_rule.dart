import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/workout/objective/operator.dart';

class EvolutionRule {

  final Operator operator;
  final Unit unit;
  final num value;

  EvolutionRule({
    required this.operator,
    required this.unit,
    required this.value,
  });

}