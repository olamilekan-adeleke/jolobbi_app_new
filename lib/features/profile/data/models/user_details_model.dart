import '../../domain/entities/user_details_entity.dart';

class UserDetailsModel extends UserDetailsEntity {
  const UserDetailsModel({
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.role,
    required super.username,
    required super.userId,
    required super.displayPicture,
    // required super.createdAt,
    required super.fcmToken,
    required super.isBlocked,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'username': username,
      'userId': userId,
      'displayPicture': displayPicture,
      // 'createdAt': createdAt.millisecondsSinceEpoch,
      'fcmToken': fcmToken,
      'isBlocked': isBlocked,
    };
  }

  factory UserDetailsModel.fromMap(Map<String, dynamic> map) {
    return UserDetailsModel(
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      role: map['role'] as String,
      username: map['username'] as String,
      userId: map['userId'] as String,
      displayPicture: map['displayPicture'] != null
          ? map['displayPicture'] as String
          : null,
      // createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      fcmToken: map['fcmToken'] as String,
      isBlocked: map['isBlocked'] as bool,
    );
  }
}
