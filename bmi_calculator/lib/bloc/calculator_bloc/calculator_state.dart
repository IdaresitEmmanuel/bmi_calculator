import 'package:bmi_calculator/auth/form_submission_status.dart';

class CalculatorState {
  final String height;
  final String heightUnit;
  final String weight;
  final String weightUnit;
  final String age;
  final String sex;
  final String? bmi;
  final int? categoryNumber;
  final String? category;
  final FormSubmissionStatus formStatus;
  final bool showResult;

  bool get isValidHeight {
    if (height.isEmpty) {
      return false;
    } else if (!RegExp(r'^[+]?([0-9]+\.?[0-9]*|\.[0-9]+)$').hasMatch(height)) {
      return false;
    } else {
      return true;
    }
  }

  bool get isValidWeight {
    if (weight.isEmpty) {
      return false;
    } else if (!RegExp(r'^[+]?([0-9]+\.?[0-9]*|\.[0-9]+)$').hasMatch(weight)) {
      return false;
    } else {
      return true;
    }
  }

  bool get isValidAge {
    if (age.isEmpty) {
      return false;
    } else if (!RegExp(r"^[+]?[0-9]+$").hasMatch(age)) {
      return false;
    } else {
      return true;
    }
  }

  CalculatorState.initialState(
      {this.height = '',
      this.heightUnit = 'cm',
      this.weight = '',
      this.weightUnit = 'kg',
      this.age = '',
      this.sex = '',
      this.bmi,
      this.categoryNumber,
      this.category,
      this.showResult = false,
      this.formStatus = const InitialFormStatus()});

  CalculatorState(
      {required this.height,
      required this.heightUnit,
      required this.weight,
      required this.weightUnit,
      required this.age,
      required this.sex,
      this.bmi,
      this.categoryNumber,
      this.category,
      required this.showResult,
      this.formStatus = const InitialFormStatus()});

  CalculatorState copyWith(
      {String? height,
      String? heightUnit,
      String? weight,
      String? weightUnit,
      String? age,
      String? sex,
      String? bmi,
      int? categoryNumber,
      String? category,
      bool? showResult,
      FormSubmissionStatus? formStatus}) {
    return CalculatorState(
        showResult: showResult ?? this.showResult,
        height: height ?? this.height,
        heightUnit: heightUnit ?? this.heightUnit,
        weightUnit: weightUnit ?? this.weightUnit,
        weight: weight ?? this.weight,
        age: age ?? this.age,
        sex: sex ?? this.sex,
        bmi: bmi ?? this.bmi,
        category: category ?? this.category,
        categoryNumber: categoryNumber ?? this.categoryNumber,
        formStatus: formStatus ?? this.formStatus);
  }
}
