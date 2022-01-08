import 'package:bmi_calculator/constant_terms.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BMI:   ${double.parse(widget.bmi).toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 10.0),
          Text(
            'BMI prime:   ${(double.parse(widget.bmi) / 25).toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 10.0),
          SfLinearGauge(
            // showLabels: false,
            showTicks: false,
            showAxisTrack: false,
            interval: 10.0,
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
                color: ConstantTerms.blue,
              ),
              LinearGaugeRange(
                startWidth: 20,
                endWidth: 20,
                startValue: 18.5,
                endValue: 24.9,
                color: ConstantTerms.green,
              ),
              LinearGaugeRange(
                  startWidth: 20,
                  endWidth: 20,
                  startValue: 25.0,
                  endValue: 29.9,
                  color: ConstantTerms.orange),
              LinearGaugeRange(
                startWidth: 20,
                endWidth: 20,
                startValue: 30.0,
                endValue: 40.0,
                color: ConstantTerms.red,
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
                      activeColor: ConstantTerms.blue,
                      groupValue: widget.categoryValue,
                      onChanged: (value) {}),
                  Text('Underweight (severe thinness)',
                      style: TextStyle(
                          color: widget.categoryValue == 1
                              ? ConstantTerms.blue
                              : Colors.black)),
                ],
              ),
              Text('below 16.0',
                  style: TextStyle(
                      color: widget.categoryValue == 1
                          ? ConstantTerms.blue
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
                      activeColor: ConstantTerms.blue,
                      onChanged: (value) {}),
                  Text('Underweight (moderate thinness)',
                      style: TextStyle(
                          color: widget.categoryValue == 2
                              ? ConstantTerms.blue
                              : Colors.black)),
                ],
              ),
              Text('16.0 - 16.9',
                  style: TextStyle(
                      color: widget.categoryValue == 2
                          ? ConstantTerms.blue
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
                      activeColor: ConstantTerms.blue,
                      onChanged: (value) {}),
                  Text('Underweight (mild thinness)',
                      style: TextStyle(
                          color: widget.categoryValue == 3
                              ? Theme.of(context).primaryColor
                              : Colors.black)),
                ],
              ),
              Text('17.0 - 18. 4',
                  style: TextStyle(
                      color: widget.categoryValue == 3
                          ? Theme.of(context).primaryColor
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
                      activeColor: ConstantTerms.green,
                      onChanged: (value) {}),
                  Text('Normal range',
                      style: TextStyle(
                          color: widget.categoryValue == 4
                              ? ConstantTerms.green
                              : Colors.black)),
                ],
              ),
              Text('18.5 - 24.9',
                  style: TextStyle(
                      color: widget.categoryValue == 4
                          ? ConstantTerms.green
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
                      activeColor: ConstantTerms.orange,
                      onChanged: (value) {}),
                  Text('Overweight (pre-obese)',
                      style: TextStyle(
                          color: widget.categoryValue == 5
                              ? ConstantTerms.orange
                              : Colors.black)),
                ],
              ),
              Text('25.0 - 29.9',
                  style: TextStyle(
                      color: widget.categoryValue == 5
                          ? ConstantTerms.orange
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
                      activeColor: ConstantTerms.red,
                      onChanged: (value) {}),
                  Text('Obese (class I)',
                      style: TextStyle(
                          color: widget.categoryValue == 6
                              ? ConstantTerms.red
                              : Colors.black)),
                ],
              ),
              Text('30.0 - 34.9',
                  style: TextStyle(
                      color: widget.categoryValue == 6
                          ? ConstantTerms.red
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
                      activeColor: ConstantTerms.red,
                      onChanged: (value) {}),
                  Text('Obese (class II)',
                      style: TextStyle(
                          color: widget.categoryValue == 7
                              ? ConstantTerms.red
                              : Colors.black)),
                ],
              ),
              Text('35.0 - 39.9',
                  style: TextStyle(
                      color: widget.categoryValue == 7
                          ? ConstantTerms.red
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
                      activeColor: ConstantTerms.red,
                      onChanged: (value) {}),
                  Text('Obese (class III)',
                      style: TextStyle(
                          color: widget.categoryValue == 8
                              ? ConstantTerms.red
                              : Colors.black)),
                ],
              ),
              Text('40.0 & above',
                  style: TextStyle(
                      color: widget.categoryValue == 8
                          ? ConstantTerms.red
                          : Colors.black)),
            ],
          )
        ],
      ),
    );
  }
}
