class YUrls {
  static String get liveBaseUrl => 'https://backend.gigsam.com';

  static String get localBaseUrl => 'http://192.168.1.99/php_web_services';

  static String get mainBaseUrl => '$liveBaseUrl/api/v1/';

//=============================== Auth Urls ============================================

  static String get loginEndPoint => '${mainBaseUrl}login';

  static String get registerEndPoint => "${mainBaseUrl}signup";

  static String get verifyMobileEndPoint => '${mainBaseUrl}verify_account';
}