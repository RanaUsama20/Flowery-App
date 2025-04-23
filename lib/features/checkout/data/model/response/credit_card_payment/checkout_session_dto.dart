import 'package:flowery_app/features/checkout/data/model/response/credit_card_payment/session_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/response/credit_card_payment/checkout_session_entity.dart';

part 'checkout_session_dto.g.dart';

@JsonSerializable()
class CheckoutSessionDto {
  final String message;
  final SessionDto session;

  CheckoutSessionDto({required this.message, required this.session});

  factory CheckoutSessionDto.fromJson(Map<String, dynamic> json) => _$CheckoutSessionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CheckoutSessionDtoToJson(this);

  CheckoutSessionEntity toDomain() => CheckoutSessionEntity(
   message: message,
    session: session.toDomain()
  );

}



