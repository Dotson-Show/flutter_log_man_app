import 'package:json_annotation/json_annotation.dart';

part 'waybill.g.dart';

@JsonSerializable()
class Waybill {
  final int id;
  @JsonKey(name: 'journey_id')
  final int journeyId;
  @JsonKey(name: 'waybill_number')
  final String? waybillNumber;
  @JsonKey(name: 'file_url')
  final String? fileUrl;
  @JsonKey(name: 'uploaded_by')
  final String? uploadedBy;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Waybill({
    required this.id,
    required this.journeyId,
    this.waybillNumber,
    this.fileUrl,
    this.uploadedBy,
    this.createdAt,
  });

  factory Waybill.fromJson(Map<String, dynamic> json) => _$WaybillFromJson(json);
  Map<String, dynamic> toJson() => _$WaybillToJson(this);
}
