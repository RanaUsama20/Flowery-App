class TrackOrderDetailsEntity {
  final String firstName;
  final String lastName;
  final String driverLatlang;
  final String userLatlang;
  final String phone;
  final String orderStatus;
  final String vehicleImage;
  final String userId;
  DateTime dateTime;
  TrackOrderDetailsEntity(
      {required this.dateTime,
      required this.driverLatlang,
      required this.userLatlang,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.orderStatus,
      required this.vehicleImage,
      required this.userId});
}
