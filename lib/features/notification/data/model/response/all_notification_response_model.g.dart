// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_notification_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllNotificationResponseModel _$AllNotificationResponseModelFromJson(
        Map<String, dynamic> json) =>
    AllNotificationResponseModel(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => Notifications.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllNotificationResponseModelToJson(
        AllNotificationResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'notifications': instance.notifications,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      totalItems: (json['totalItems'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'limit': instance.limit,
      'totalItems': instance.totalItems,
    };

Notifications _$NotificationsFromJson(Map<String, dynamic> json) =>
    Notifications(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      V: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.V,
    };
