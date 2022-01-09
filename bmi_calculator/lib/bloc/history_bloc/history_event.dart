abstract class HistoryEvent {}

class FetchHistory extends HistoryEvent {}

class RefreshHistory extends HistoryEvent {}

class DeleteHistory extends HistoryEvent {
  final int id;
  DeleteHistory({required this.id});
}

class DeleteAllHistory extends HistoryEvent {}
