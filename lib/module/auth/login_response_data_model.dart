// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  JobsApp? jobsApp;
  int? statusCode;
  String? msg;
  int? success;

  LoginResponseModel({this.jobsApp, this.statusCode, this.msg, this.success});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        jobsApp:
            json["JOBS_APP"] == null
                ? null
                : JobsApp.fromJson(json["JOBS_APP"]),
        statusCode: json["status_code"],
        msg: json["msg"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
    "JOBS_APP": jobsApp?.toJson(),
    "status_code": statusCode,
    "msg": msg,
    "success": success,
  };
}

class JobsApp {
  dynamic userId;
  dynamic serviceId;
  dynamic serviceTypeId;
  String? usertype;
  String? name;
  String? email;
  String? phone;
  String? userImage;

  JobsApp({
    this.userId,
    this.serviceId,
    this.serviceTypeId,
    this.usertype,
    this.name,
    this.email,
    this.phone,
    this.userImage,
  });

  factory JobsApp.fromJson(Map<String, dynamic> json) => JobsApp(
    userId: json["user_id"],
    serviceId: json["service_id"],
    serviceTypeId: json["service_type_id"],
    usertype: json["usertype"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    userImage: json["user_image"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "service_id": serviceId,
    "service_type_id": serviceTypeId,
    "usertype": usertype,
    "name": name,
    "email": email,
    "phone": phone,
    "user_image": userImage,
  };
}
