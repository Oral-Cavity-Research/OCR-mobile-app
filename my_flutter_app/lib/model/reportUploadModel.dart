// image_upload_model.dart

class ReportUploadModel {
  final String teleconEntryId;
  final String reportName;

  ReportUploadModel({
    required this.teleconEntryId,
    required this.reportName
  });

  Map<String, dynamic> toJson() {
    return {
      'telecon_entry_id': teleconEntryId,
      'report_name': reportName
    };
  }
  factory ReportUploadModel.fromJson(Map<String, dynamic> json){
    return ReportUploadModel(
        teleconEntryId: json['telecon_entry_id'],
        reportName: json['report_name']
    );
  }

}
