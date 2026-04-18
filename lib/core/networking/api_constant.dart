class ApiConstants {
  static const String baseUrl = 'http://localhost:3000/api/v1';

  static const String auth = '/auth';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String refresh = '/refresh-token';
  static const String logout = '/revoke-token';
  static const String socialLogin = '/social-login';

  //notfications
  static const String openMeteoBaseUrl =
      'https://api.open-meteo.com/v1/forecast';
  //result
  static const String plant = 'http://localhost:4000/api/plant';
}
