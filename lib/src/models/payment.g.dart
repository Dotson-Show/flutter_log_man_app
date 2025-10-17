// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
  id: (json['id'] as num).toInt(),
  journeyId: (json['journey_id'] as num).toInt(),
  amount: (json['amount'] as num).toDouble(),
  status: json['status'] as String,
  paymentMethod: json['payment_method'] as String,
  paymentType: json['payment_type'] as String,
  referenceId: json['reference_id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  'id': instance.id,
  'journey_id': instance.journeyId,
  'amount': instance.amount,
  'status': instance.status,
  'payment_method': instance.paymentMethod,
  'payment_type': instance.paymentType,
  'reference_id': instance.referenceId,
  'created_at': instance.createdAt?.toIso8601String(),
};
