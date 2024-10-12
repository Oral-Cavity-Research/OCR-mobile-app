import 'HabbitDto.dart';

class TeleconEntryRequest {
  final String startTime;
  final String endTime;
  final String complaint;
  final String findings;
  final List<HabbitDto>? currentHabits;

  TeleconEntryRequest({
    required this.startTime,
    required this.endTime,
    required this.complaint,
    required this.findings,
    this.currentHabits
  });

  Map<String, dynamic> toJson() {
    return {
      'start_time': startTime,
      'end_time': endTime,
      'complaint': complaint,
      'findings': findings,
      'current_habits': currentHabits
    };
  }
  factory TeleconEntryRequest.fromJson(Map<String, dynamic> json){
    return TeleconEntryRequest(
        startTime: json['start_time'],
        endTime: json['end_time'],
        complaint: json['complaint'],
        findings: json['findings'],
        currentHabits: json['current_habits']);
  }

}
