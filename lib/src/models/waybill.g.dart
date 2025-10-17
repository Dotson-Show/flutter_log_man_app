// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waybill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Waybill _$WaybillFromJson(Map<String, dynamic> json) => Waybill(
  id: (json['id'] as num).toInt(),
  journeyId: (json['journey_id'] as num).toInt(),
  waybillNumber: json['waybill_number'] as String?,
  fileUrl: json['file_url'] as String?,
  uploadedBy: json['uploaded_by'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$WaybillToJson(Waybill instance) => <String, dynamic>{
  'id': instance.id,
  'journey_id': instance.journeyId,
  'waybill_number': instance.waybillNumber,
  'file_url': instance.fileUrl,
  'uploaded_by': instance.uploadedBy,
  'created_at': instance.createdAt?.toIso8601String(),
};
