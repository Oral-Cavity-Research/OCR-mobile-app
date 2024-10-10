class HabbitDto {
  final String habit;
  final String frequency;

  HabbitDto({
    required this.habit,
    required this.frequency,
  });

  Map<String, dynamic> toJson() {
    return {
      'habit': habit,
      'frequency': frequency,
    };
  }
  factory HabbitDto.fromJson(Map<String, dynamic> json){
    return HabbitDto(
      habit: json['habit'],
      frequency: json['frequency'],
    );
  }
}