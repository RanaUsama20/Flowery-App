import 'package:json_annotation/json_annotation.dart';
import '../../../../domain/entity/response/cash_payment/cash_payment_response_entity.dart';
import 'cash_order_dto.dart';

part 'cash_payment_response_dto.g.dart';

@JsonSerializable()
class CashPaymentResponseDto {
  String? message;
  CashOrderDto? order;

  CashPaymentResponseDto({this.message, this.order});

  factory CashPaymentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CashPaymentResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CashPaymentResponseDtoToJson(this);
  CashPaymentResponseEntity toDomain() => CashPaymentResponseEntity(
     message: message,
    order: order?.toDomain()
  );

}
