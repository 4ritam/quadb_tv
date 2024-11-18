import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String time;
  final List<String> days;

  const Schedule({
    required this.time,
    required this.days,
  });

  @override
  List<Object?> get props => [time, days];
}
