import '../../domain/entities/schedule.dart';

class ScheduleModel extends Schedule {
  const ScheduleModel({
    required super.time,
    required super.days,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      time: json['time'],
      days: List<String>.from(json['days']),
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'days': days,
      };
}
