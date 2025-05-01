import 'package:flowery_app/features/notification/domain/entity/all_notification_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'all_notification_response_model.g.dart';

@JsonSerializable()
class AllNotificationResponseModel {
  String? message;
  Metadata? metadata;
  List<Notifications>? notifications;

  AllNotificationResponseModel(
      {this.message, this.metadata, this.notifications});

  factory AllNotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AllNotificationResponseModelFromJson(json);
  // {
  //   message = json['message'];
  //   metadata = json['metadata'] != null
  //       ? new Metadata.fromJson(json['metadata'])
  //       : null;
  //   if (json['notifications'] != null) {
  //     notifications = <Notifications>[];
  //     json['notifications'].forEach((v) {
  //       notifications!.add(Notifications.fromJson(v));
  //     });
  //   }
  // }
}

@JsonSerializable()
class Metadata {
  int? currentPage;
  int? totalPages;
  int? limit;
  int? totalItems;

  Metadata({this.currentPage, this.totalPages, this.limit, this.totalItems});

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
  // {
  //   currentPage = json['currentPage'];
  //   totalPages = json['totalPages'];
  //   limit = json['limit'];
  //   totalItems = json['totalItems'];
  // }
}

@JsonSerializable()
class Notifications {
  @JsonKey(name: '_id')
  String? id;
  String? title;
  String? body;
  String? createdAt;
  String? updatedAt;
  @JsonKey(name: '__v')
  int? V;

  Notifications(
      {this.id, this.title, this.body, this.createdAt, this.updatedAt, this.V});

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

  AllNotificationEntity toAllNotificationEntity() =>
      AllNotificationEntity(id: id!, titiel: title!, body: body!);
  // {
  //   id = json['_id'];
  //   title = json['title'];
  //   body = json['body'];
  //   createdAt = json['createdAt'];
  //   updatedAt = json['updatedAt'];
  //   V = json['__v'];
  // }
}
