class ReviewRequest {
  final String provisionalDiagnosis;
  final String managementSuggestions;
  final String referralSuggestions;
  final String otherComments;


  ReviewRequest({
    required this.provisionalDiagnosis,
    required this.managementSuggestions,
    required this.referralSuggestions,
    required this.otherComments,

  });

  Map<String, dynamic> toJson() {
    return {
      'provisional_diagnosis': provisionalDiagnosis,
      'management_suggestions': managementSuggestions,
      'referral_suggestions': referralSuggestions,
      'other_comments': otherComments,

    };
  }
  factory ReviewRequest.fromJson(Map<String, dynamic> json){
    return ReviewRequest(
        provisionalDiagnosis: json['provisional_diagnosis'],
        managementSuggestions: json['management_suggestions'],
        referralSuggestions: json['referral_suggestions'],
        otherComments: json['other_comments']);

  }

}
