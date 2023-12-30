import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:sevin_rm/data/models/otp/otp_model.dart';

import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/models/auth/auth_model.dart';
import '../../../Core/data_source/base_remote_data_source.dart';
import '../../../Core/models/empty_model.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../core/di/di_manager.dart';
import '../endpoints/endpoints.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl();

  Future<Result> login(
    String phone,
    String password,
  ) async {
    String deviceToken = DIManager.findDep<SharedPrefs>().getDeviceToken()  ?? '123';
    String deviceType = DIManager.findDep<SharedPrefs>().getDeviceType()!;

    return await RemoteDataSource.request<AuthenticateModel>(
      converter: (model) => AuthenticateModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: false},
      data: {
        "mobile": phone,
        "password": password,
        "device_token": deviceToken,
        "device_type": deviceType
      },
      url: AppEndpoints.baseUrl + AppEndpoints.loginUrl,
    );
  }

  Future<Result<AuthenticateModel>> register(
      {required UserAuthenticateModel userAuthenticateModel,
      File? image,
      required String password}) async {
    FormData formData;
    String deviceToken = DIManager.findDep<SharedPrefs>().getDeviceToken()!;
    String deviceType = DIManager.findDep<SharedPrefs>().getDeviceType()!;

    var profilePic;
    if (image != null) {
      profilePic = await MultipartFile.fromFile(
        image.path ?? "",
        filename: basename(image.path ?? ""),
      );
    }
    formData = FormData.fromMap({
      "first_name": userAuthenticateModel.firstName,
      "last_name": userAuthenticateModel.lastName,
      "user_name": userAuthenticateModel.userName,
      "email": userAuthenticateModel.email,
      "password": password,
      "gender": userAuthenticateModel.gender,
      "mobile": userAuthenticateModel.mobile,
      "latitude": userAuthenticateModel.latitude,
      "longitude": userAuthenticateModel.longitude,
      "is_accept_terms": 1,
      "device_token": deviceToken,
      "device_type": deviceType,
      "user_image": profilePic
    });
    return await RemoteDataSource.request<AuthenticateModel>(
      converter: (model) => AuthenticateModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: false},
      formData: formData,
      url: AppEndpoints.baseUrl + AppEndpoints.signupUrl,
    );
  }

// Future<Result<EmptyModel>> refreshToken(params) async {
//   return await RemoteDataSource.request<EmptyModel>(
//     converter: (model) => EmptyModel(model),
//     method: HttpMethod.POST,
//     headers: {RemoteDataSource.requiresToken: false},
//     url: AppEndpoints.REFRESH_TOKEN,
//     data: params,
//   );
// }
//
  Future<Result<EmptyModel>> logout() async {
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      url: AppEndpoints.baseUrl + AppEndpoints.logoutUrl,
      headers: {RemoteDataSource.requiresToken: true},
    );
  }

  @override
  Future<Result> resetPassword(String mobile, String password) async {
    print(
        "PasswordToken : ${DIManager.findDep<SharedPrefs>().getPasswordToken()}");
    return await RemoteDataSource.request<EmptyModel>(
      converter: (model) => EmptyModel(model),
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "mobile": mobile,
        "password": password,
        "password_token": DIManager.findDep<SharedPrefs>().getPasswordToken()
      },
      url: AppEndpoints.baseUrl + AppEndpoints.resetPassword,
    );
  }

  @override
  Future<Result> otpForgetPassword(String mobile) async {
    return await RemoteDataSource.request<OtpModel>(
      converter: (model) => OtpModel.fromJson(model),
      method: HttpMethod.POST,
      data: {"mobile": mobile},
      url: AppEndpoints.baseUrl + AppEndpoints.verifyPassword,
      headers: {RemoteDataSource.requiresToken: false},
    );
  }

  @override
  Future<Result> sendVerificationCode(String mobile) async {
    return await RemoteDataSource.request<OtpModel>(
      method: HttpMethod.POST,
      converter: (model) => OtpModel.fromJson(model),
      data: {"mobile": mobile},
      url: AppEndpoints.baseUrl + AppEndpoints.sendVerificationCode,
      headers: {RemoteDataSource.requiresToken: false},
    );
  }

  @override
  Future<Result> validateMobileNumber(String otpCode, String mobile) async {
    return await RemoteDataSource.request<bool>(
      converter: (model) => model["status"],
      method: HttpMethod.POST,
      data: {
        // "mobile": "971$mobile",
        "mobile": "$mobile",
        "otp_code": otpCode,
      },
      url: AppEndpoints.baseUrl + AppEndpoints.validateMobileNumber,
      headers: {RemoteDataSource.requiresToken: false},
    );
  }

//
// @override
// Future<Result<bool>> firebase(String FCMtoken) async{
//   return await RemoteDataSource.request<bool>(
//     converter: (model) => model,
//     method: HttpMethod.PUT,
//     url: AppEndpoints.firebase,
//     data: {"token":FCMtoken}
//   );
// }
}

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<Result> login(
    String phone,
    String password,
  );

  Future<Result<AuthenticateModel>> register(
      {required UserAuthenticateModel userAuthenticateModel,
      File? image,
      required String password});

//
// Future<Result<EmptyModel>> refreshToken(params);
//
  Future<Result<EmptyModel>> logout();

  Future<Result> resetPassword(String mobile, String password);

  Future<Result> otpForgetPassword(String mobile);

  Future<Result> sendVerificationCode(String mobile);

  Future<Result<dynamic>> validateMobileNumber(String otpCode, String mobile);

//
//
// Future<Result<bool>> firebase(String FCMtoken);
}
