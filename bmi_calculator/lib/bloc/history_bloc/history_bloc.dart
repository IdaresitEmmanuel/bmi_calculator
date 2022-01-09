import 'package:bmi_calculator/bloc/history_bloc/history_event.dart';
import 'package:bmi_calculator/bloc/history_bloc/history_state.dart';
import 'package:bmi_calculator/data/db_provider.dart';
import 'package:bmi_calculator/data/models/bmi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryState.initialState()) {
    on<FetchHistory>((event, emit) async {
      emit(state.copyWith(historyListStatus: HistoryLoading()));
      List<Bmi> list = await DBProvider.instance.getAllBmi();
      List<Bmi> descList = [];
      for (var i = list.length - 1; i >= 0; i--) {
        descList.add(list[i]);
      }
      emit(state.copyWith(
          list: descList,
          historyListStatus: HistoryLoaded(),
          isEmpty: list.isEmpty));
    });
    on<RefreshHistory>((event, emit) async {
      List<Bmi> list = await DBProvider.instance.getAllBmi();
      emit(state.copyWith(isEmpty: list.isEmpty, list: list));
    });
    on<DeleteHistory>((event, emit) async {
      await DBProvider.instance.deleteBmi(event.id);
      add(RefreshHistory());
      Fluttertoast.showToast(
          msg: 'item deleted',
          backgroundColor: Colors.white,
          textColor: Colors.black);
    });
    on<DeleteAllHistory>((event, emit) async {
      await DBProvider.instance.deleteAllBmi();
      add(RefreshHistory());
      Fluttertoast.showToast(
          msg: 'history successfully deleted',
          backgroundColor: Colors.white,
          textColor: Colors.black);
    });
  }
}
