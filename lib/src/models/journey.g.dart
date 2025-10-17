// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Journey _$JourneyFromJson(Map<String, dynamic> json) => Journey(
  id: (json['id'] as num).toInt(),
  origin: json['origin'] as String,
  destination: json['destination'] as String,
  transportType: json['transport_type'] as String,
  status: json['status'] as String,
  assignedVendor: json['assigned_vendor'] as String?,
  assignedDriver: json['assigned_driver'] as String?,
  scheduledAt: json['scheduled_at'] == null
      ? null
      : DateTime.parse(json['scheduled_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$JourneyToJson(Journey instance) => <String, dynamic>{
  'id': instance.id,
  'origin': instance.origin,
  'destination': instance.destination,
  'transport_type': instance.transportType,
  'status': instance.status,
  'assigned_vendor': instance.assignedVendor,
  'assigned_driver': instance.assignedDriver,
  'scheduled_at': instance.scheduledAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
};
