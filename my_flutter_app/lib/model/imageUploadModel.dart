// image_upload_model.dart
import 'package:my_flutter_app/model/annotationModel.dart';

class ImageUploadModel {
  final String teleconEntryId;
  final String imageName;
  final String location;
  final String clinicalDiagnosis;
  final bool lesionsAppear;
  final String predictedCat;

  ImageUploadModel({
    required this.teleconEntryId,
    required this.imageName,
    required this.location,
    required this.clinicalDiagnosis,
    required this.lesionsAppear,
    required this.predictedCat,
  });

  Map<String, dynamic> toJson() {
    return {
      'telecon_entry_id': teleconEntryId,
      'image_name': imageName,
      'location': location,
      'clinical_diagnosis': clinicalDiagnosis,
      'lesions_appear': lesionsAppear.toString(),
      'predicted_cat': predictedCat
    };
  }
  factory ImageUploadModel.fromJson(Map<String, dynamic> json){
    return ImageUploadModel(
        teleconEntryId: json['telecon_entry_id'],
        imageName: json['image_name'],
        location: json['location'],
        clinicalDiagnosis: json['clinical_diagnosis'],
        lesionsAppear: json['lesions_appear'],
        predictedCat: json['predicted_cat']);


  }

}
