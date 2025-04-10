// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_seller_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BestSellerResponseDto _$BestSellerResponseDtoFromJson(
        Map<String, dynamic> json) =>
    BestSellerResponseDto(
      message: json['message'] as String?,
      bestSeller: (json['bestSeller'] as List<dynamic>?)
          ?.map((e) => BestSellerDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BestSellerResponseDtoToJson(
        BestSellerResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'bestSeller': instance.bestSeller,
    };
