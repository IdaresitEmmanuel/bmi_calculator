import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String heightUnit = 'cm';
  String weightUnit = 'kg';

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
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).dividerColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0))),
                          child: Row(
                            children: [
                              Flexible(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  controller: heightController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              )),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            style: BorderStyle.solid,
                                            color:
                                                Theme.of(context).dividerColor,
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
                                      child: Text('m'),
                                      value: 'm',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      heightUnit = value as String;
                                    });
                                  },
                                ),
                              )
                            ],
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
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).dividerColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0))),
                          child: Row(
                            children: [
                              Flexible(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  controller: weightController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              )),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            style: BorderStyle.solid,
                                            color:
                                                Theme.of(context).dividerColor,
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
                              )
                            ],
                          ),
                        ),
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
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  // height: 40,
                                  // width: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Theme.of(context).dividerColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: TextFormField(
                                    controller: ageController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
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
                    height: 10,
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
                      onPressed: () {},
                    ),
                  )
                ],
              )),
              const BMIResult(),
            ],
          ),
        ),
      ),
    ));
  }
}

// BMI Result class
class BMIResult extends StatefulWidget {
  const BMIResult({Key? key}) : super(key: key);

  @override
  _BMIResultState createState() => _BMIResultState();
}

class _BMIResultState extends State<BMIResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: [
          Row(
            children: const [Text('BMI:')],
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
            markerPointers: const [
              LinearShapePointer(
                offset: 20.0,
                value: 22.0,
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
                      groupValue: 1,
                      onChanged: (value) {}),
                  const Text('Underweight (severe thinness)'),
                ],
              ),
              const Text('below 16.0'),
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
                      groupValue: 2,
                      activeColor: Colors.blue,
                      onChanged: (value) {}),
                  const Text('Underweight (moderate thinness)'),
                ],
              ),
              const Text('16.0 - 16.9'),
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
                      groupValue: 3,
                      activeColor: Colors.blue,
                      onChanged: (value) {}),
                  const Text('Underweight (mild thinness)'),
                ],
              ),
              const Text('17.0 - 18. 4'),
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
                      groupValue: 4,
                      activeColor: Colors.green,
                      onChanged: (value) {}),
                  const Text('Normal range'),
                ],
              ),
              const Text('18.5 - 24.9'),
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
                      groupValue: 5,
                      activeColor: Colors.amber,
                      onChanged: (value) {}),
                  const Text('Overweight (pre-obese)'),
                ],
              ),
              const Text('25.0 - 29.9'),
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
                      groupValue: 6,
                      activeColor: Colors.red,
                      onChanged: (value) {}),
                  const Text('Obese (class I)'),
                ],
              ),
              const Text('30.0 - 34.9'),
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
                      groupValue: 7,
                      activeColor: Colors.red,
                      onChanged: (value) {}),
                  const Text('Obese (class II)'),
                ],
              ),
              const Text('35.0 - 39.9'),
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
                      groupValue: 8,
                      activeColor: Colors.red,
                      onChanged: (value) {}),
                  const Text('Obese (class III)'),
                ],
              ),
              const Text('40.0 & above'),
            ],
          ),
        ],
      ),
    );
  }
}
