class ReviewerDetails {
  final String id;
  final String userName;
  final String regNo;

  ReviewerDetails({
    required this.id,
    required this.userName,
    required this.regNo,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': userName,
      'reg_no': regNo
    };
  }
  factory ReviewerDetails.fromJson(Map<String, dynamic> json){
    return ReviewerDetails(
        id: json['_id'],
        userName: json['username'],
        regNo: json['reg_no']
    );
  }
}