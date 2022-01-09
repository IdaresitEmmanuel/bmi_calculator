import 'package:bmi_calculator/auth/form_submission_status.dart';
import 'package:bmi_calculator/bloc/calculator_bloc/calculator_event.dart';
import 'package:bmi_calculator/bloc/calculator_bloc/calculator_state.dart';
import 'package:bmi_calculator/data/db_provider.dart';
import 'package:bmi_calculator/data/models/bmi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState.initialState()) {
    // height update
    on<HeightChanged>(
        (event, emit) => emit(state.copyWith(height: event.height)));
    // height unit update
    on<HeightUnitChanged>(
        (event, emit) => emit(state.copyWith(heightUnit: event.heightUnit)));
    // weight update
    on<WeightChanged>(
        (event, emit) => emit(state.copyWith(weight: event.weight)));
    // weight unit update
    on<WeightUnitChanged>(
        (event, emit) => emit(state.copyWith(weightUnit: event.weightUnit)));
    // age update
    on<AgeChanged>((event, emit) => emit(state.copyWith(age: event.age)));
    // sex update
    on<SexChanged>((event, emit) => emit(state.copyWith(sex: event.sex)));
    // show result
    on<ShowResult>(
        (event, emit) => emit(state.copyWith(showResult: event.showResult)));
    // form submitted
    on<BMISubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      await _calculateBMI(emit);
      await _setCategoryValue(emit);
      DateTime now = DateTime.now();
      Bmi bmiModel = Bmi(
          date: now,
          gender: state.sex,
          age: int.parse(state.age),
          bmi: double.parse(state.bmi!),
          bmiPrime: (double.parse(state.bmi!) / 25),
          categoryNumber: state.categoryNumber!,
          category: state.category!);
      DBProvider.instance.insertBmi(bmiModel.toMap());
      emit(state.copyWith(formStatus: SubmissionSuccessful()));
      emit(state.copyWith(showResult: true));
    });
  }

  _calculateBMI(Emitter emit) async {
    String heightUnit = state.heightUnit;
    String weightUnit = state.weightUnit;
    double height = double.parse(state.height);
    double weight = double.parse(state.weight);
    String bmi = '';
    if (heightUnit == 'cm') {
      double heightInMeters = _cmToMeter(height);
      double weightInKg = weightUnit == 'lbs' ? _lbsToKg(weight) : weight;
      bmi = (weightInKg / (heightInMeters * heightInMeters)).toString();
    }

    if (heightUnit == 'inch') {
      double weightInLbs = weightUnit == 'kg' ? _kgToLbs(weight) : weight;
      bmi = ((weightInLbs * 703) / (height * height)).toString();
    }

    if (heightUnit == 'ft') {
      double heightInInch = _ftToInc(height);
      double weightInLbs = weightUnit == 'kg' ? _kgToLbs(weight) : weight;
      bmi = ((weightInLbs * 703) / (heightInInch * heightInInch)).toString();
    }
    emit(state.copyWith(bmi: bmi));
  }

  _cmToMeter(double cm) {
    return cm / 100;
  }

  _ftToInc(double ft) {
    return ft * 12;
  }

  _kgToLbs(double kg) {
    return kg * 2.20462262;
  }

  _lbsToKg(double lbs) {
    return lbs / 2.20462262;
  }

  _setCategoryValue(Emitter emit) async {
    String? bmi = state.bmi;
    List<String> categoryList = [
      'Underweight (severe thinness)',
      'Underweight (moderate thinness)',
      'Underweight (mild thinness)',
      'Normal range',
      'Overweight (pre-obese)',
      'Obese (class I)',
      'Obese (class II)',
      'Obese (class III)',
    ];
    if (bmi != null) {
      double b = double.parse(double.parse(bmi).toStringAsFixed(1));
      if (b < 16.0) {
        emit(state.copyWith(categoryNumber: 1, category: categoryList[0]));

        // categoryValue = 1;
      } else if (b >= 16.0 && b <= 16.9) {
        emit(state.copyWith(categoryNumber: 2, category: categoryList[1]));
        // categoryValue = 2;
      } else if (b >= 17.0 && b <= 18.4) {
        emit(state.copyWith(categoryNumber: 3, category: categoryList[2]));
        // categoryValue = 3;
      } else if (b >= 18.5 && b <= 24.9) {
        emit(state.copyWith(categoryNumber: 4, category: categoryList[3]));
        // categoryValue = 4;
      } else if (b >= 25.0 && b <= 29.9) {
        emit(state.copyWith(categoryNumber: 5, category: categoryList[4]));
        // categoryValue = 5;
      } else if (b >= 30.0 && b <= 34.9) {
        emit(state.copyWith(categoryNumber: 6, category: categoryList[5]));
        // categoryValue = 6;
      } else if (b >= 35.0 && b <= 39.9) {
        emit(state.copyWith(categoryNumber: 7, category: categoryList[6]));
        // categoryValue = 7;
      } else if (b >= 40.0) {
        emit(state.copyWith(categoryNumber: 8, category: categoryList[7]));
        // categoryValue = 8;
      }
    }
  }
}
