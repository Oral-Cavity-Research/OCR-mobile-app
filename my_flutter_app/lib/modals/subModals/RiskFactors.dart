class RiskFactor {
  String habit;
  String frequency;
  String duration;

  RiskFactor({
    required this.habit,
    required this.frequency,
    required this.duration,
  });

  factory RiskFactor.fromJson(Map<String, dynamic> json) {
    return RiskFactor(
      habit: json['habit'] as String,
      frequency: json['frequency'] as String,
      duration: json['duration'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'habit': habit,
      'frequency': frequency,
      'duration': duration,
    };
  }
}
