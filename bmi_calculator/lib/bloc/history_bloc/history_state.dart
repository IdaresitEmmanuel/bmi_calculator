import 'package:bmi_calculator/data/models/bmi.dart';

class HistoryState {
  final bool isEmpty;
  final List<Bmi> list;
  final HistoryListStatus historyListStatus;

  HistoryState.initialState(
      {this.isEmpty = false,
      this.list = const [],
      this.historyListStatus = const InitialHistoryStatus()});
  HistoryState(
      {required this.isEmpty,
      required this.list,
      required this.historyListStatus});
  HistoryState copyWith(
      {bool? isEmpty, List<Bmi>? list, HistoryListStatus? historyListStatus}) {
    return HistoryState(
        isEmpty: isEmpty ?? this.isEmpty,
        list: list ?? this.list,
        historyListStatus: historyListStatus ?? this.historyListStatus);
  }
}

abstract class HistoryListStatus {
  const HistoryListStatus();
}

class InitialHistoryStatus extends HistoryListStatus {
  const InitialHistoryStatus();
}

class HistoryLoading extends HistoryListStatus {}

class HistoryLoaded extends HistoryListStatus {}
