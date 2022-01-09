import 'package:bmi_calculator/bloc/calculator_bloc/calculator_bloc.dart';
import 'package:bmi_calculator/bloc/calculator_bloc/calculator_event.dart';
import 'package:bmi_calculator/bloc/calculator_bloc/calculator_state.dart';
import 'package:bmi_calculator/screens/calculator/bmi_result.dart';
import 'package:bmi_calculator/screens/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolling_switch/rolling_switch.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final _formKey = GlobalKey<FormState>();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();

  _refresh() {
    _formKey.currentState!.reset();
    setState(() {
      heightController.clear();
      heightController.clear();
      weightController.clear();
      ageController.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    _formKey.currentState!.dispose();
  }

  Widget _appbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/mini_logo_primary.png',
            width: 40,
            height: 40,
          ),
          Row(
            children: [
              BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) {
                  return InkResponse(
                    onTap: () {
                      _refresh();
                      context
                          .read<CalculatorBloc>()
                          .add(ShowResult(showResult: false));
                    },
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: Color(0xFF777777),
                    ),
                  );
                },
              ),
              const SizedBox(width: 20.0),
              InkResponse(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const History()));
                },
                child:
                    const Icon(Icons.history_rounded, color: Color(0xFF777777)),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                _appbar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _calculatorForm(),
                        BlocBuilder<CalculatorBloc, CalculatorState>(
                          builder: (context, state) {
                            if (state.showResult) {
                              return BMIResult(
                                  bmi: state.bmi.toString(),
                                  categoryNumber: state.categoryNumber!);
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _calculatorForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // input height field
          _heightField(),
          const SizedBox(height: 10),
          // Weight
          _weightField(),
          const SizedBox(height: 10),
          // age
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: _ageField(),
                  ),
                  const SizedBox(width: 20),
                  _sexSwitch(),
                ]),
          ),
          const SizedBox(height: 20),
          // submit button
          _submitButton(),
        ],
      ),
    );
  }

  Widget _heightField() {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Height',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                onChanged: (value) {
                  context
                      .read<CalculatorBloc>()
                      .add(HeightChanged(height: value));
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'this field is empty';
                  } else if (!state.isValidHeight) {
                    return 'input correct value';
                  }
                },
                controller: heightController,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBDBDBD))),
                  suffixIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                style: BorderStyle.solid,
                                color: Theme.of(context).dividerColor,
                                width: 1.0))),
                    child: DropdownButton(
                      underline: const SizedBox.shrink(),
                      // elevation: 0,
                      value: state.heightUnit,
                      items: const [
                        DropdownMenuItem(
                          child: Text('cm'),
                          value: 'cm',
                        ),
                        DropdownMenuItem(
                          child: Text('ft'),
                          value: 'ft',
                        ),
                        DropdownMenuItem(
                          child: Text('inch'),
                          value: 'inch',
                        ),
                      ],
                      onChanged: (value) => context
                          .read<CalculatorBloc>()
                          .add(HeightUnitChanged(heightUnit: value as String)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _weightField() {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Weight',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                onChanged: (value) {
                  context
                      .read<CalculatorBloc>()
                      .add(WeightChanged(weight: value));
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'this field is empty';
                  } else if (!state.isValidWeight) {
                    return 'input correct value';
                  }
                },
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFBDBDBD))),
                    suffixIcon: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Theme.of(context).dividerColor,
                                  width: 1.0))),
                      child: DropdownButton(
                        underline: const SizedBox.shrink(),
                        // elevation: 0,
                        value: state.weightUnit,
                        items: const [
                          DropdownMenuItem(
                            child: Text('kg'),
                            value: 'kg',
                          ),
                          DropdownMenuItem(
                            child: Text('lbs'),
                            value: 'lbs',
                          ),
                        ],
                        onChanged: (value) => context
                            .read<CalculatorBloc>()
                            .add(
                                WeightUnitChanged(weightUnit: value as String)),
                      ),
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _ageField() {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Age',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) {
                context.read<CalculatorBloc>().add(AgeChanged(age: value));
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'this field is empty';
                }
                if (!state.isValidAge) {
                  return 'input correct value';
                }
              },
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  suffix: Text('Years'),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBDBDBD)))),
            ),
          ],
        );
      },
    );
  }

  Widget _sexSwitch() {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 30.0),
          child: RollingSwitch.widget(
            initialState: state.sex == 'f' ? true : false,
            onChanged: (value) {
              context
                  .read<CalculatorBloc>()
                  .add(SexChanged(sex: value == true ? 'f' : 'm'));
            },
            height: 50,
            rollingInfoLeft: RollingWidgetInfo(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Image.asset('assets/images/male_primary.png',
                  width: 30.0, height: 30.0),
              text: const Text('Male',
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
            rollingInfoRight: RollingWidgetInfo(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Image.asset('assets/images/female_primary.png',
                  width: 30.0, height: 30.0),
              text: const Text('Female',
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
          ),
        );
      },
    );
  }

  Widget _submitButton() {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 20.0),
          width: 100.0,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: TextButton(
            child: const Text(
              'Calculate',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<CalculatorBloc>().add(BMISubmitted());
              } else {
                context
                    .read<CalculatorBloc>()
                    .add(ShowResult(showResult: false));
              }
              FocusScope.of(context).unfocus();
            },
          ),
        );
      },
    );
  }
}
