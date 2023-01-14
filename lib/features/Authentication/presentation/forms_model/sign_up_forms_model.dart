class SignUpFormModel {
  SignUpFormModel({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.username,
  });

  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final String username;

  Map<String, dynamic> toMap(String userId) {
    List<String> _searchKey = [];

    fullName.split("").forEach((element) {
      _searchKey.add(element.toLowerCase());
    });

    return <String, dynamic>{
      "userId": userId,
      'email': email,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'username': username,
      "createdAt": DateTime.now().toIso8601String(),
      "displayPicture": "",
      "searchKey": _searchKey,
    };
  }
}
