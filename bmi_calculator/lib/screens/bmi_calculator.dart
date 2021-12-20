import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String heightUnit = 'cm';
  String weightUnit = 'kg';
  String? bmi;
  int categoryValue = 0;

  _submit() {
    if (_formKey.currentState!.validate()) {
      _calculateBMI();
      FocusScope.of(context).unfocus();
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
        bmi = ((height * 703) / (weight * weight)).toString();
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
        bmi = ((heightInInch * 703) / (weight * weight)).toString();
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
      double b = double.parse(bmi!);
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
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
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
                    InkResponse(
                      onTap: () {},
                      child: const Icon(Icons.more_vert_rounded),
                    )
                  ],
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // input height field

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Height',
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'this field is empty';
                                } else {
                                  return null;
                                }
                              },
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                suffixIcon: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Weight',
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'this field is empty';
                                } else {
                                  return null;
                                }
                              },
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  suffixIcon: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Age'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'this field is empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: ageController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              RollingSwitch.icon(
                                onChanged: (value) {},
                                height: 50,
                                rollingInfoLeft: const RollingIconInfo(
                                  backgroundColor: Colors.blue,
                                  icon: Icons.male_rounded,
                                  iconColor: Colors.blue,
                                  text: Text('Male',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                rollingInfoRight: const RollingIconInfo(
                                  backgroundColor: Colors.blueAccent,
                                  icon: Icons.female_rounded,
                                  iconColor: Colors.blueAccent,
                                  text: Text('Female',
                                      style: TextStyle(color: Colors.white)),
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
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: TextButton(
                          child: const Text(
                            'Calculate',
                            style: TextStyle(color: Colors.white),
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
    ));
  }
}

// BMI Result class
class BMIResult extends StatefulWidget {
  const BMIResult({Key? key, required this.bmi, required this.categoryValue})
      : super(key: key);

  final String bmi;
  final int categoryValue;

  @override
  _BMIResultState createState() => _BMIResultState();
}

class _BMIResultState extends State<BMIResult> {
  ValueNotifier<int> categoryNotifier = ValueNotifier<int>(0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: [
          Row(
            children: [const Text('BMI:'), Text(widget.bmi)],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: const [Text('BMI prime:')],
          ),
          const SizedBox(height: 10.0),
          SfLinearGauge(
            // showLabels: false,
            showTicks: false,
            showAxisTrack: false,
            minimum: 0.0,
            maximum: 40.0,
            markerPointers: [
              LinearShapePointer(
                offset: 20.0,
                value: double.parse(widget.bmi),
              )
            ],
            ranges: const <LinearGaugeRange>[
              LinearGaugeRange(
                edgeStyle: LinearEdgeStyle.startCurve,
                startWidth: 20,
                endWidth: 20,
                startValue: 0.0,
                endValue: 18.4,
                color: Colors.blue,
              ),
              LinearGaugeRange(
                startWidth: 20,
                endWidth: 20,
                startValue: 18.5,
                endValue: 24.9,
                color: Colors.green,
              ),
              LinearGaugeRange(
                  startWidth: 20,
                  endWidth: 20,
                  startValue: 25.0,
                  endValue: 29.9,
                  color: Colors.amber),
              LinearGaugeRange(
                startWidth: 20,
                endWidth: 20,
                startValue: 30.0,
                endValue: 40.0,
                color: Colors.red,
                edgeStyle: LinearEdgeStyle.endCurve,
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                      visualDensity: VisualDensity.compact,
                      value: 1,
                      activeColor: Colors.blue,
                      groupValue: widget.categoryValue,
                      onChanged: (value) {}),
                  Text('Underweight (severe thinness)',
                      style: TextStyle(
                          color: widget.categoryValue == 1
                              ? Colors.blue
                              : Colors.black)),
                ],
              ),
              Text('below 16.0',
                  style: TextStyle(
                      color: widget.categoryValue == 1
                          ? Colors.blue
                          : Colors.black)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                      visualDensity: VisualDensity.compact,
                      value: 2,
                      groupValue: widget.categoryValue,
                      activeColor: Colors.blue,
                      onChanged: (value) {}),
                  Text('Underweight (moderate thinness)',
                      style: TextStyle(
                          color: widget.categoryValue == 2
                              ? Colors.blue
                              : Colors.black)),
                ],
              ),
              Text('16.0 - 16.9',
                  style: TextStyle(
                      color: widget.categoryValue == 2
                          ? Colors.blue
                          : Colors.black)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                      visualDensity: VisualDensity.compact,
                      value: 3,
                      groupValue: widget.categoryValue,
                      activeColor: Colors.blue,
                      onChanged: (value) {}),
                  Text('Underweight (mild thinness)',
                      style: TextStyle(
                          color: widget.categoryValue == 3
                              ? Colors.blue
                              : Colors.black)),
                ],
              ),
              Text('17.0 - 18. 4',
                  style: TextStyle(
                      color: widget.categoryValue == 3
                          ? Colors.blue
                          : Colors.black)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                      visualDensity: VisualDensity.compact,
                      value: 4,
                      groupValue: widget.categoryValue,
                      activeColor: Colors.green,
                      onChanged: (value) {}),
                  Text('Normal range',
                      style: TextStyle(
                          color: widget.categoryValue == 4
                              ? Colors.green
                              : Colors.black)),
                ],
              ),
              Text('18.5 - 24.9',
                  style: TextStyle(
                      color: widget.categoryValue == 4
                          ? Colors.green
                          : Colors.black)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                      visualDensity: VisualDensity.compact,
                      value: 5,
                      groupValue: widget.categoryValue,
                      activeColor: Colors.amber,
                      onChanged: (value) {}),
                  Text('Overweight (pre-obese)',
                      style: TextStyle(
                          color: widget.categoryValue == 5
                              ? Colors.amber
                              : Colors.black)),
                ],
              ),
              Text('25.0 - 29.9',
                  style: TextStyle(
                      color: widget.categoryValue == 5
                          ? Colors.amber
                          : Colors.black)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                      visualDensity: VisualDensity.compact,
                      value: 6,
                      groupValue: widget.categoryValue,
                      activeColor: Colors.red,
                      onChanged: (value) {}),
                  Text('Obese (class I)',
                      style: TextStyle(
                          color: widget.categoryValue == 6
                              ? Colors.red
                              : Colors.black)),
                ],
              ),
              Text('30.0 - 34.9',
                  style: TextStyle(
                      color: widget.categoryValue == 6
                          ? Colors.red
                          : Colors.black)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                      visualDensity: VisualDensity.compact,
                      value: 7,
                      groupValue: widget.categoryValue,
                      activeColor: Colors.red,
                      onChanged: (value) {}),
                  Text('Obese (class II)',
                      style: TextStyle(
                          color: widget.categoryValue == 7
                              ? Colors.red
                              : Colors.black)),
                ],
              ),
              Text('35.0 - 39.9',
                  style: TextStyle(
                      color: widget.categoryValue == 7
                          ? Colors.red
                          : Colors.black)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                      visualDensity: VisualDensity.compact,
                      value: 8,
                      groupValue: widget.categoryValue,
                      activeColor: Colors.red,
                      onChanged: (value) {}),
                  Text('Obese (class III)',
                      style: TextStyle(
                          color: widget.categoryValue == 8
                              ? Colors.red
                              : Colors.black)),
                ],
              ),
              Text('40.0 & above',
                  style: TextStyle(
                      color: widget.categoryValue == 8
                          ? Colors.red
                          : Colors.black)),
            ],
          )
        ],
      ),
    );
  }
}
