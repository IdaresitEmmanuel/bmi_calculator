import 'package:bmi_calculator/data/db_provider.dart';
import 'package:bmi_calculator/data/models/bmi.dart';
import 'package:bmi_calculator/screens/calculator/bmi_result.dart';
import 'package:bmi_calculator/screens/history.dart';
import 'package:flutter/material.dart';
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
  String heightUnit = 'cm';
  String weightUnit = 'kg';
  String? bmi;
  int categoryValue = 0;
  DateTime now = DateTime.now();
  bool isFemale = false;

  _refresh() {
    _formKey.currentState!.reset();
    setState(() {
      heightController.clear();
      heightController.clear();
      weightController.clear();
      ageController.clear();
      bmi = null;
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

  _submit() {
    if (_formKey.currentState!.validate()) {
      _calculateBMI();
      FocusScope.of(context).unfocus();
      Bmi bmiModel = Bmi(
          date: now,
          gender: isFemale ? 'f' : 'm',
          age: int.parse(ageController.text),
          bmi: double.parse(bmi!),
          bmiPrime: (double.parse(bmi!) / 25),
          category: categoryValue);
      DBProvider.instance.insertBmi(bmiModel.toMap());
    } else {
      FocusScope.of(context).unfocus();
      setState(() {
        bmi = null;
        categoryValue = 0;
      });
    }
  }

  _calculateBMI() {
    if (heightUnit == 'cm') {
      var height = double.parse(heightController.text);
      double heightInMeters = _cmToMeter(height);
      double weight = weightUnit == 'lbs'
          ? _lbsToKg(double.parse(weightController.text))
          : double.parse(weightController.text);
      setState(() {
        bmi = (weight / (heightInMeters * heightInMeters)).toString();
        _setCategoryValue();
      });
    }

    if (heightUnit == 'inch') {
      double height = double.parse(heightController.text);
      double weight = weightUnit == 'kg'
          ? _kgToLbs(double.parse(weightController.text))
          : double.parse(weightController.text);
      setState(() {
        bmi = ((weight * 703) / (height * height)).toString();
        _setCategoryValue();
      });
    }

    if (heightUnit == 'ft') {
      double height = double.parse(heightController.text);
      double heightInInch = _ftToInc(height);
      double weight = weightUnit == 'kg'
          ? _kgToLbs(double.parse(weightController.text))
          : double.parse(weightController.text);
      setState(() {
        bmi = ((weight * 703) / (heightInInch * heightInInch)).toString();
        _setCategoryValue();
      });
    }
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

  _setCategoryValue() {
    if (bmi != null) {
      double b = double.parse(double.parse(bmi!).toStringAsFixed(1));
      if (b < 16.0) {
        categoryValue = 1;
      } else if (b >= 16.0 && b <= 16.9) {
        categoryValue = 2;
      } else if (b >= 17.0 && b <= 18.4) {
        categoryValue = 3;
      } else if (b >= 18.5 && b <= 24.9) {
        categoryValue = 4;
      } else if (b >= 25.0 && b <= 29.9) {
        categoryValue = 5;
      } else if (b >= 30.0 && b <= 34.9) {
        categoryValue = 6;
      } else if (b >= 35.0 && b <= 39.9) {
        categoryValue = 7;
      } else if (b >= 40.0) {
        categoryValue = 8;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
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
                        InkResponse(
                          onTap: _refresh,
                          child: const Icon(Icons.refresh_rounded,
                              color: Color(0xFF777777)),
                        ),
                        const SizedBox(width: 20.0),
                        InkResponse(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const History()));
                          },
                          child: const Icon(Icons.history_rounded,
                              color: Color(0xFF777777)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // input height field

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Height',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'this field is empty';
                                        } else if (!RegExp(
                                                r'^[+]?([0-9]+\.?[0-9]*|\.[0-9]+)$')
                                            .hasMatch(value)) {
                                          return 'input correct value';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: heightController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFBDBDBD))),
                                        suffixIcon: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: Theme.of(context)
                                                          .dividerColor,
                                                      width: 1.0))),
                                          child: DropdownButton(
                                            underline: const SizedBox.shrink(),
                                            // elevation: 0,
                                            value: heightUnit,
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
                                            onChanged: (value) {
                                              setState(() {
                                                heightUnit = value as String;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Weight
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Weight',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'this field is empty';
                                        } else if (!RegExp(
                                                r'^[+]?([0-9]+\.?[0-9]*|\.[0-9]+)$')
                                            .hasMatch(value)) {
                                          return 'input correct value';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: weightController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFBDBDBD))),
                                          suffixIcon: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    left: BorderSide(
                                                        style:
                                                            BorderStyle.solid,
                                                        color: Theme.of(context)
                                                            .dividerColor,
                                                        width: 1.0))),
                                            child: DropdownButton(
                                              underline:
                                                  const SizedBox.shrink(),
                                              // elevation: 0,
                                              value: weightUnit,
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
                                              onChanged: (value) {
                                                setState(() {
                                                  weightUnit = value as String;
                                                });
                                              },
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              // age
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Age',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'this field is empty';
                                                } else if (!RegExp(
                                                        r"^[+]?[0-9]+$")
                                                    .hasMatch(value)) {
                                                  return 'input correct value';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              controller: ageController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  suffix: Text('Years'),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFFBDBDBD)))),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 30.0),
                                        child: RollingSwitch.widget(
                                          initialState: isFemale,
                                          onChanged: (value) {
                                            setState(() {
                                              isFemale = value;
                                            });
                                          },
                                          height: 50,
                                          rollingInfoLeft: RollingWidgetInfo(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            icon: Image.asset(
                                                'assets/images/male_primary.png',
                                                width: 30.0,
                                                height: 30.0),
                                            text: const Text('Male',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0)),
                                          ),
                                          rollingInfoRight: RollingWidgetInfo(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            icon: Image.asset(
                                                'assets/images/female_primary.png',
                                                width: 30.0,
                                                height: 30.0),
                                            text: const Text('Female',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0)),
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // submit button
                              Container(
                                margin: const EdgeInsets.only(left: 20.0),
                                width: 100.0,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: TextButton(
                                  child: const Text(
                                    'Calculate',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onPressed: _submit,
                                ),
                              )
                            ],
                          )),
                      bmi != null
                          ? BMIResult(
                              bmi: bmi!,
                              categoryValue: categoryValue,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
