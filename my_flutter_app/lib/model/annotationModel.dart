class AnnotationModel {
  final int id;
  final String name;
  final List<int> annotations;
  final List<int> bbox;


  AnnotationModel({
    required this.id,
    required this.name,
    required this.annotations,
    required this.bbox
  });
  Map<String,dynamic> toJson(){
    return {
      'id' : id,
      'name': name,
      'annotations' : annotations,
      'bbox' : bbox
    };
  }

  factory AnnotationModel.fromJson(Map<String, dynamic> json) {
    return AnnotationModel(
      id: json['id'],
      name: json['name'],
      annotations: List<int>.from(json['annotations']),
      bbox: List<int>.from(json['bbox']),
    );
  }
}
