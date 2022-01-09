import 'package:bmi_calculator/bloc/history_bloc/history_bloc.dart';
import 'package:bmi_calculator/bloc/history_bloc/history_event.dart';
import 'package:bmi_calculator/bloc/history_bloc/history_state.dart';
import 'package:bmi_calculator/constant_terms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final HistoryBloc _historyBloc = HistoryBloc();
  final DateFormat _dateFormat = DateFormat('MMM dd yyyy');

  Color _getColor(int catVal) {
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
    _historyBloc.add(FetchHistory());
  }

  Widget _buildList(int index) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
              color: _getColor(state.list[index].categoryNumber),
              borderRadius: BorderRadius.circular(20.0)),
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
                    _dateFormat.format(state.list[index].date),
                    style: const TextStyle(color: Colors.white),
                  ),
                  InkResponse(
                      onTap: () {
                        _historyBloc
                            .add(DeleteHistory(id: state.list[index].id!));
                      },
                      child: const Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                      ))
                ],
              ),
              const SizedBox(height: 8.0),
              Image.asset(
                  state.list[index].gender == 'f'
                      ? 'assets/images/female_white.png'
                      : 'assets/images/male_white.png',
                  width: 50.0,
                  height: 50.0),
              const SizedBox(height: 8.0),
              Text('Age: ${state.list[index].age}yrs',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white)),
              const SizedBox(height: 4.0),
              Text('BMI: ${state.list[index].bmi.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white)),
              const SizedBox(height: 4.0),
              Text(
                  'BMI prime: ${state.list[index].bmiPrime.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white)),
              const SizedBox(height: 4.0),
              Text(state.list[index].category,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _historyBloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
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

                    BlocBuilder<HistoryBloc, HistoryState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {
                            if (state.list.isNotEmpty) {
                              _historyBloc.add(DeleteAllHistory());
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'history is already empty',
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black);
                            }
                          },
                          child: const Text('CLEAR ALL'),
                          // style: TextStyle(color: Colors.blue),
                        );
                      },
                    ),
                    // )
                  ],
                ),
              ),
              // list
              Flexible(child: BlocBuilder<HistoryBloc, HistoryState>(
                  builder: (context, state) {
                if (state.isEmpty) {
                  return _historyIsEmpty();
                }
                if (state.historyListStatus is HistoryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.historyListStatus is HistoryLoaded) {
                  return _historyList();
                }
                return _historyIsEmpty();
              }))
            ],
          ),
        ),
      ),
    );
  }

  Widget _historyIsEmpty() {
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
                color: Theme.of(context).textTheme.caption?.color),
          ),
        ],
      ),
    );
  }

  Widget _historyList() {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        return ListView.builder(
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              return _buildList(index);
            });
      },
    );
  }
}
