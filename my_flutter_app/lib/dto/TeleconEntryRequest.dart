import 'HabbitDto.dart';

class TeleconEntryRequest {
  final String startTime;
  final String endTime;
  final String complaints;
  final String finding;
  final List<HabbitDto>? currentHabits;

  TeleconEntryRequest({
    required this.startTime,
    required this.endTime,
    required this.complaints,
    required this.finding,
    this.currentHabits
  });

  Map<String, dynamic> toJson() {
    return {
      'start_time': startTime,
      'end_time': endTime,
      'complaints': complaints,
      'finding': finding,
      'current_habits': currentHabits
    };
  }
  factory TeleconEntryRequest.fromJson(Map<String, dynamic> json){
    return TeleconEntryRequest(
        startTime: json['start_time'],
        endTime: json['end_time'],
        complaints: json['complaints'],
        finding: json['finding'],
        currentHabits: json['current_habits']);
  }

}
