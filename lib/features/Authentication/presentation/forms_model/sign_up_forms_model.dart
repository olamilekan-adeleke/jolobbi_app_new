// ignore_for_file: no_leading_underscores_for_local_identifiers

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

  Map<String, dynamic> toMap(String userId) {
    List<String> _searchKey = [];

    fullName.value.split("").forEach((element) {
      _searchKey.add(element.toLowerCase());
    });

    return <String, dynamic>{
      "userId": userId,
      'email': email.value,
      'password': password.value,
      'fullName': fullName.value,
      'phoneNumber': phoneNumber.value,
      'username': username.value,
      "createdAt": DateTime.now().toIso8601String(),
      "displayPicture": "",
      "searchKey": _searchKey,
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
}
