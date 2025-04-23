import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/response/credit_card_payment/session_entity.dart';

part 'session_dto.g.dart';

@JsonSerializable()
class SessionDto {
  final String id;
  final String object;
  final int amount_subtotal;
  final int amount_total;
  final String currency;
  final String status;
  final String payment_status;
  final String? customer_email;
  final String url;

  SessionDto({
    required this.id,
    required this.object,
    required this.amount_subtotal,
    required this.amount_total,
    required this.currency,
    required this.status,
    required this.payment_status,
    this.customer_email,
    required this.url,
  });

  factory SessionDto.fromJson(Map<String, dynamic> json) => _$SessionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SessionDtoToJson(this);
  SessionEntity toDomain() => SessionEntity(
     id: id,
    url: url,
    amount_subtotal: amount_subtotal,
    amount_total: amount_total,
    currency: currency,
    object: object,
    payment_status: payment_status,
    status: status,
    customer_email: customer_email
  );

}