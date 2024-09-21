// image_upload_service.dart
import 'dart:io';

import '../../URL.dart';
import '../../model/reportUploadModel.dart';



class ReportUploadService {
  Future<int> uploadReport(
      ReportUploadModel reportData, File reportFile) async {
    final responseCode = await reportUpload(
      reportData.teleconEntryId,
      reportData.reportName,
      reportFile,
    );
    return responseCode;
  }
}
