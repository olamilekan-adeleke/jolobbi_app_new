// import 'local_storage.dart';

enum UserAccountStatus { hasAccount, pending, noAccount }

class SessionManager {
  SessionManager._internal();
  static final SessionManager instance = SessionManager._internal();
  factory SessionManager() => instance;

  // static final LocalStorage _localStorage = LocalStorage();
  static final Map<String, dynamic> _loginData = {};
  String? cachedToken;
  String get token => cachedToken ?? _loginData['accessToken'] ?? '';
  String get email => _loginData['email'] ?? '';
  String get username => _loginData['username'] ?? '';
  String get fullname => _loginData['fullname'] ?? '';
  String get phone => _loginData['phone'] ?? '';
  String get balance => _loginData['balance'] ?? 0;
  bool get hasKyc => _loginData['hasKyc'] ?? false;

  UserAccountStatus accountStatue() {
    final String status = _loginData['fullname'] ?? '';

    if (status == "noAccount") {
      return UserAccountStatus.noAccount;
    } else if (status == "hasAccount") {
      return UserAccountStatus.hasAccount;
    } else if (status == "pending") {
      return UserAccountStatus.pending;
    } else {
      return UserAccountStatus.noAccount;
    }
  }

  void setLoginData(Map<String, dynamic> data) {
    _loginData.clear();
    _loginData.addAll(data);
  }
}
