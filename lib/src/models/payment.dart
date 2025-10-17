import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  final int id;
  @JsonKey(name: 'journey_id')
  final int journeyId;
  final double amount;
  final String status;
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  @JsonKey(name: 'payment_type')
  final String paymentType;
  @JsonKey(name: 'reference_id')
  final String? referenceId;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Payment({
    required this.id,
    required this.journeyId,
    required this.amount,
    required this.status,
    required this.paymentMethod,
    required this.paymentType,
    this.referenceId,
    this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
