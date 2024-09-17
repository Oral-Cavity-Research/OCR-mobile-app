class RiskFactors {
  final String habit;
  final String frequency;
  final String duration;

  RiskFactors({
    required this.habit,
    required this.frequency,
    required this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      'habit': habit,
      'frequency': frequency,
      'duration': duration
    };
  }
  factory RiskFactors.fromJson(Map<String, dynamic> json){
    return RiskFactors(
        habit: json['habit'],
        frequency: json['frequency'],
        duration: json['duration']
    );
  }
}