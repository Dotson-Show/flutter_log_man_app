import 'package:json_annotation/json_annotation.dart';

part 'journey.g.dart';

@JsonSerializable()
class Journey {
  final int id;
  final String origin;
  final String destination;
  @JsonKey(name: 'transport_type')
  final String transportType;
  final String status;
  @JsonKey(name: 'assigned_vendor')
  final String? assignedVendor;
  @JsonKey(name: 'assigned_driver')
  final String? assignedDriver;
  @JsonKey(name: 'scheduled_at')
  final DateTime? scheduledAt;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Journey({
    required this.id,
    required this.origin,
    required this.destination,
    required this.transportType,
    required this.status,
    this.assignedVendor,
    this.assignedDriver,
    this.scheduledAt,
    required this.createdAt,
  });

  factory Journey.fromJson(Map<String, dynamic> json) => _$JourneyFromJson(json);
  Map<String, dynamic> toJson() => _$JourneyToJson(this);
}
