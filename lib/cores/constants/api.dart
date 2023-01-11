class ApiEndpoints {
  static const String _version = '/api';
  static const String _baseUrl = 'http://3.93.241.217$_version';

  /// Authentication
  static const String login = '$_baseUrl/auth/login';
  static const String signUp = '$_baseUrl/auth/signup';
  static const String changePassword = '$_baseUrl/auth/changepassword';
  static const String resetPassword = '$_baseUrl/auth/resetpassword';
  static const String editProfile = '$_baseUrl/user/updateprofile';
  static const String getProperty =
      'https://propertyapi.ivantage.africa/api/ivantage/property';
  static const String filterProperty =
      "https://propertyapi.ivantage.africa/api/ivantage/findproperty";
  static String getWallet(String email) =>
      "$_baseUrl/paystack/fetchcustomer?email=$email";
  static String uploadKyc(String username) =>
      "$_baseUrl/user/uploadkyc?username=$username";
}
