// image_upload_model.dart

import '../dto/HabbitDto.dart';

class TeleconEntryModel {
  final String id;
  final String patient;
  final String clinicianId;
  final String complaint;
  final String startTime;
  final String endTime;
  final String findings;
  final String status;
  final List<HabbitDto> currentHabits;
  final String updated;
  final List<String> reviewers;
  final List<String> reviews;
  final List<String> images;
  final List<String> reports;
  final String createdAt ;
  final String updatedAt;


  TeleconEntryModel({
    required this.id,
    required this.patient,
    required this.clinicianId,
    required this.complaint,
    required this.startTime,
    required this.endTime,
    required this.findings,
    required this.status,
    required this.currentHabits,
    required this.updated,
    required this.reviewers,
    required this.reviews,
    required this.images,
    required this.reports,
    required this.createdAt,
    required this.updatedAt
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patient': patient,
      'clinician_id':clinicianId,
      'complaint': complaint,
      'start_time': startTime,
      'end_time':endTime,
      'findings':findings,
      'status':status,
      'current_habits': currentHabits.map((habit) => habit.toJson()).toList(),
      'updated': updated,
      'reviewers':reviewers,
      'reviews':reviews,
      'images':images,
      'reports':reports,
      'createdAt':createdAt,
      'updatedAt':updatedAt
    };
  }
  factory TeleconEntryModel.fromJson(Map<String, dynamic> json){
    return TeleconEntryModel(
      id: json['_id'],
      patient: json['patient'],
      clinicianId: json['clinician_id'],
      complaint: json['complaint'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      findings: json['findings'],
      status: json['status'],
      currentHabits: (json['current_habits'] as List<dynamic>)
          .map((habit) => HabbitDto.fromJson(habit))
          .toList(),
      updated: json['updated'],
      reviewers: List<String>.from(json['reviewers']),
      reviews: List<String>.from(json['reviews']),
      images: List<String>.from(json['images']),
      reports: List<String>.from(json['reports']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

}
