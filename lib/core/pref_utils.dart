import 'package:otpless_demo/module/auth/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static String prefName = "com.example.otpless_demo";

  static String isLogin = 'login';

  static SharedPreferences? _sharedPreferences;

  static clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _sharedPreferences?.clear();
    prefs.clear();
  }

  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<SharedPreferences> get getPref async {
    return _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }

  /// Store and Retrieve Users UserId and Token;
  static Future<bool> setUserInfo({
    required String userId,
    required String token,
    bool isFromEmail = false,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList("loggedInUserWithToken", [
      userId,
      token,
      isFromEmail ? 'email' : 'mobile',
    ]);
  }

  /// Store and Retrieve Users UserId and Token;
  static Future<UserInfoModel> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList("loggedInUserWithToken");
    if (data != null) {
      return UserInfoModel(
        userId: data[0],
        token: data[1],
        isFromEmail: data[2] == 'email' ? true : false,
        isDataFetched: true,
      );
    } else {
      return UserInfoModel(userId: "", token: "", isDataFetched: false);
    }
  }

  // saveUserData(String? name, String? image) async {
  //   HomeMapController controller = HomeMapController.instance;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   controller.initializeUserIcon();
  //   await prefs.setString(
  //       'userData', jsonEncode({'name': name, 'image': image}));
  // }
  //
  // static Future<Map<String, dynamic>> getUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return jsonDecode(prefs.getString('userData') ?? "");
  // }

  static getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var image = prefs.getString('userImage') ?? "";
    return image;
  }

  static setIsPermissionCalled(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("setIsPermissionCalled", value);
  }

  static Future<bool> getIsPermissionCalled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("setIsPermissionCalled") ?? false;
  }

  static setLogin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLogin, value);
  }

  static Future<bool> getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLogin) ?? true;
  }

  static getIsSignIn() async {
    return _sharedPreferences!.getBool(isLogin) ?? false;
  }
}
