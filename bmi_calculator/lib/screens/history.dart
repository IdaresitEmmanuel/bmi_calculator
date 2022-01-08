import 'package:bmi_calculator/constant_terms.dart';
import 'package:bmi_calculator/data/db_provider.dart';
import 'package:bmi_calculator/data/models/bmi.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Bmi> list = [];
  final DateFormat _dateFormat = DateFormat('MMM dd yyyy');
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

  Color _getColor(int index) {
    int catVal = list[index].category;
    if (catVal == 1 || catVal == 2 || catVal == 3) {
      return ConstantTerms.blue;
    }
    if (catVal == 4) {
      return ConstantTerms.green;
    }
    if (catVal == 5) {
      return ConstantTerms.orange;
    }
    if (catVal == 6 || catVal == 7 || catVal == 8) {
      return ConstantTerms.red;
    }
    return Colors.black;
  }

  @override
  void initState() {
    super.initState();
    // _getList();
  }

  // _getList() async {
  //   list.clear();
  //   list = await DBProvider.instance.getAllBmi();
  //   setState(() {
  //     list = list;
  //   });
  // }

  Widget _buildList(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: _getColor(index), borderRadius: BorderRadius.circular(20.0)),
      height: 220,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _dateFormat.format(list[index].date),
                style: const TextStyle(color: Colors.white),
              ),
              InkResponse(
                  onTap: () {
                    DBProvider.instance.deleteBmi(list[index].id!);
                    setState(() {});
                    Fluttertoast.showToast(
                        msg: 'item deleted',
                        backgroundColor: Colors.white,
                        textColor: Colors.black);
                  },
                  child: const Icon(
                    Icons.delete_rounded,
                    color: Colors.white,
                  ))
            ],
          ),
          const SizedBox(height: 8.0),
          Image.asset(
              list[index].gender == 'f'
                  ? 'assets/images/female_white.png'
                  : 'assets/images/male_white.png',
              width: 50.0,
              height: 50.0),
          const SizedBox(height: 8.0),
          Text('Age: ${list[index].age}yrs',
              style: const TextStyle(fontSize: 16.0, color: Colors.white)),
          const SizedBox(height: 4.0),
          Text('BMI: ${list[index].bmi.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 16.0, color: Colors.white)),
          const SizedBox(height: 4.0),
          Text('BMI prime: ${list[index].bmiPrime.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 16.0, color: Colors.white)),
          const SizedBox(height: 4.0),
          Text(categoryList[list[index].category - 1],
              style: const TextStyle(fontSize: 16.0, color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    InkResponse(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text('History', style: TextStyle(fontSize: 20.0)),
                  ]),

                  TextButton(
                    onPressed: () {
                      if (list.isNotEmpty) {
                        DBProvider.instance.deleteAllBmi();
                        setState(() {});
                        Fluttertoast.showToast(
                            msg: 'history successfully deleted',
                            backgroundColor: Colors.white,
                            textColor: Colors.black);
                      } else {
                        Fluttertoast.showToast(
                            msg: 'history is already empty',
                            backgroundColor: Colors.white,
                            textColor: Colors.black);
                      }
                    },
                    child: const Text('CLEAR ALL'),
                    // style: TextStyle(color: Colors.blue),
                  ),
                  // )
                ],
              ),
            ),
            // list
            Flexible(
                child: FutureBuilder(
              future: DBProvider.instance.getAllBmi(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  list.clear();
                  List<Bmi> data = snapShot.data as List<Bmi>;
                  if (data.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/history_is_empty.png',
                            width: 240.0,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'History is empty',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color:
                                    Theme.of(context).textTheme.caption?.color),
                          ),
                        ],
                      ),
                    );
                  }
                  for (var i = data.length - 1; i >= 0; i--) {
                    list.add(data[i]);
                  }
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return _buildList(index);
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
