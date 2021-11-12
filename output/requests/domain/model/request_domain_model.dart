import 'package:flutter/foundation.dart';

@immutable
class RequestDomainModel {
  const RequestDomainModel({
    required this.clientCode,
    required this.patientId,
    required this.exams,
    required this.sampleId,
  });

  final String clientCode;
  final String patientId;
  final String exams;
  final String sampleId;

  static RequestDomainModel fromRemoteModel(RequestRemoteModel r) {
    return RequestDomainModel(
      clientCode: r.clientCode,
      patientId: r.patientId,
      exams: r.exams,
      sampleId: r.sampleId,
    );
  }

  factory RequestDomainModel.fromJson(Map<String, dynamic> json) =>
      RequestDomainModel(
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

  RequestDomainModel clone() => RequestDomainModel(
      clientCode: clientCode,
      patientId: patientId,
      exams: exams,
      sampleId: sampleId);

  RequestDomainModel copyWith({
    String? clientCode,
    String? patientId,
    String? exams,
    String? sampleId,
  }) =>
      RequestDomainModel(
        clientCode: clientCode ?? this.clientCode,
        patientId: patientId ?? this.patientId,
        exams: exams ?? this.exams,
        sampleId: sampleId ?? this.sampleId,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestDomainModel &&
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
