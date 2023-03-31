import 'package:equatable/equatable.dart';

class UserDetailsEntity extends Equatable {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String role;
  final String username;
  final String userId;
  final String? displayPicture;
  final DateTime createdAt;
  final String fcmToken;
  final bool isBlocked;

  const UserDetailsEntity({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.username,
    required this.userId,
    required this.displayPicture,
    required this.createdAt,
    required this.fcmToken,
    required this.isBlocked,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'username': username,
      'userId': userId,
      'displayPicture': displayPicture,
      'createdAt': createdAt,
      'fcmToken': fcmToken,
      'isBlocked': isBlocked,
    };
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        phoneNumber,
        role,
        username,
        userId,
        displayPicture,
        createdAt,
        fcmToken,
        isBlocked,
      ];
}
