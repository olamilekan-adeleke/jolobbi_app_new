import 'package:formz/formz.dart';

import '../../../../cores/utils/formz_validator/email_formz_validator.dart';
import '../../../../cores/utils/formz_validator/password_formz_validator.dart';
import '../../../../cores/utils/formz_validator/required_formz_validator.dart';
import '../../../../cores/utils/formz_validator/username_formz_validator.dart';

class SignUpFormModel with FormzMixin {
  SignUpFormModel({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.fullName = const Required.pure(),
    this.phoneNumber = const Required.pure(),
    this.username = const Username.pure(),
  });

  final Email email;
  final Password password;
  final Required fullName;
  final Required phoneNumber;
  final Username username;

  Map<String, dynamic> toMap({required String userId, String? fcmToken}) {
    List<String> searchKey = [];

    String lastSearchKey = '';
    fullName.value.split("").forEach((element) {
      lastSearchKey += element.toLowerCase();
      searchKey.add(lastSearchKey);
    });

    return <String, dynamic>{
      "userId": userId,
      'email': email.value,
      'password': password.value,
      'fullName': fullName.value,
      'phoneNumber': phoneNumber.value,
      'username': username.value,
      "createdAt": DateTime.now().toIso8601String(),
      "displayPicture": null,
      "isBlocked": false,
      "fcmToken": fcmToken,
      "searchKey": searchKey,
    };
  }

  @override
  List<FormzInput> get inputs => [
        email,
        password,
        fullName,
        phoneNumber,
        username,
      ];

  SignUpFormModel copyWith({
    Email? email,
    Password? password,
    Required? fullName,
    Required? phoneNumber,
    Username? username,
  }) {
    return SignUpFormModel(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
    );
  }
}
