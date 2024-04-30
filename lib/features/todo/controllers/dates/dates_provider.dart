import 'package:riverpod_annotation/riverpod_annotation.dart';
part'dates_provider.g.dart';


//setting start time
@riverpod
class StartTimeState extends _$StartTimeState {
  @override
  String build(){
    return "";

  }

  void setStart(String newState){
    state = newState;
  }

  List<int> dates(DateTime startDate) {
    DateTime now = DateTime.now();
    Duration differnce = startDate.difference(now);

    int days = differnce.inDays;
    int hours = differnce.inHours % 24;
    int minutes = differnce.inMinutes % 60;
    int seconds= differnce.inSeconds  % 60;

    return [days,hours, minutes, seconds];

  }
}

@riverpod
class FinishTimeState extends _$FinishTimeState {
  @override
  String build(){
    return "";

  }

  void setStart(String newState){
    state = newState;
  }
}

@riverpod
class DateState extends _$DateState{
  DateTime startTime = DateTime.now();
  @override
  String build() {
    return "";
  }

  void setStart(String newState) {
    state = newState;
  }

  void setStartDate(DateTime newState) {
    startTime = newState;
  }
}

@riverpod
class NotifierState extends _$NotifierState {
  @override
  DateTime build() {
    return ref.read(dateStateProvider.notifier).startTime;
  }
}








