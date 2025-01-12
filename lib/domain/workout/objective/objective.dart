import 'package:overload/domain/workout/objective/evolution_rule.dart';
import 'package:overload/domain/workout/sets.dart';

class Objective {

  final Sets sets;
  final EvolutionRule evolutionRule;

  Objective({
    required this.sets,
    required this.evolutionRule,
  });
}
