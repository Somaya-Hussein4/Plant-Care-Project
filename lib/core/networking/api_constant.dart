class ApiConstants {
  static const String baseUrl = 'http://10.0.2.2:3000/api/v1';

  static const String auth = '/auth';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String refresh = '/refresh-token';
  static const String logout = '/revoke-token';
  static const String socialLogin = '/social-login';
  static const String forgetPassword = '/forget-password';
  static const String resetPassword = '/reset-password';
  //profile
  static const String profile = '/user/profile-image';

  //notfications
  static const String openMeteoBaseUrl =
      'https://api.open-meteo.com/v1/forecast';
  //result
  static const String plant = 'http://10.0.2.2:3000/api/plant';
  //http://localhost:5000/api/plant/check-image-quality?lang=ar
}
