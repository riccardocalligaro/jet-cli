import 'package:flutter/foundation.dart';

@immutable
class RequestRemoteModel {
  const RequestRemoteModel({
    required this.clientCode,
    required this.patientId,
    required this.exams,
    required this.sampleId,
  });

  final String clientCode;
  final String patientId;
  final String exams;
  final String sampleId;

  factory RequestRemoteModel.fromJson(Map<String, dynamic> json) =>
      RequestRemoteModel(
          clientCode: json['ClientCode'] as String,
          patientId: json['PatientId'] as String,
          exams: json['Exams'] as String,
          sampleId: json['SampleId'] as String);

  Map<String, dynamic> toJson() => {
        'ClientCode': clientCode,
        'PatientId': patientId,
        'Exams': exams,
        'SampleId': sampleId
      };

  RequestRemoteModel clone() => RequestRemoteModel(
      clientCode: clientCode,
      patientId: patientId,
      exams: exams,
      sampleId: sampleId);

  RequestRemoteModel copyWith({
    String? clientCode,
    String? patientId,
    String? exams,
    String? sampleId,
  }) =>
      RequestRemoteModel(
        clientCode: clientCode ?? this.clientCode,
        patientId: patientId ?? this.patientId,
        exams: exams ?? this.exams,
        sampleId: sampleId ?? this.sampleId,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestRemoteModel &&
          clientCode == other.clientCode &&
          patientId == other.patientId &&
          exams == other.exams &&
          sampleId == other.sampleId;

  @override
  int get hashCode =>
      clientCode.hashCode ^
      patientId.hashCode ^
      exams.hashCode ^
      sampleId.hashCode;
}
