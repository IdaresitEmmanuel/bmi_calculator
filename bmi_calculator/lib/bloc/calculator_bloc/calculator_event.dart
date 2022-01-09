abstract class CalculatorEvent {}

class HeightChanged extends CalculatorEvent {
  final String height;

  HeightChanged({required this.height});
}

class HeightUnitChanged extends CalculatorEvent {
  final String heightUnit;

  HeightUnitChanged({required this.heightUnit});
}

class WeightChanged extends CalculatorEvent {
  final String weight;

  WeightChanged({required this.weight});
}

class WeightUnitChanged extends CalculatorEvent {
  final String weightUnit;

  WeightUnitChanged({required this.weightUnit});
}

class AgeChanged extends CalculatorEvent {
  final String age;

  AgeChanged({required this.age});
}

class SexChanged extends CalculatorEvent {
  final String sex;

  SexChanged({required this.sex});
}

class ShowResult extends CalculatorEvent {
  final bool showResult;
  ShowResult({required this.showResult});
}

class BMISubmitted extends CalculatorEvent {}
