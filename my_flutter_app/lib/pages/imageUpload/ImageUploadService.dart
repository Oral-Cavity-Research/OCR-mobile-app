// image_upload_service.dart
import 'dart:io';

import '../../URL.dart';
import '../../model/imageUploadModel.dart';


class ImageUploadService {
  Future<int> uploadImage(
      ImageUploadModel imageData, File imageFile) async {
    final responseCode = await imageUpload(
      imageData.teleconEntryId,
      imageData.imageName,
      imageData.location,
      imageData.clinicalDiagnosis,
      imageData.lesionsAppear,
      imageData.predictedCat,
      imageFile,
    );
    return responseCode;
  }
}
