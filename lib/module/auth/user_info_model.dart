class UserInfoModel {
  final String userId;
  final String token;
  bool isDataFetched;
  bool isFromEmail;

  UserInfoModel(
      {required this.userId,
      required this.token,
      this.isDataFetched = false,
      this.isFromEmail = false});
}
