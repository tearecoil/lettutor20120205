import 'package:dio/dio.dart';
import 'package:lettutor20120205/models/user/User.dart';
import 'package:lettutor20120205/models/user/tokens.dart';
import 'package:lettutor20120205/service-api/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required Function(User) onSuccess,
    required Function() onError,
  }) async {
    try {
      final response = await DioService().post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final data = response.data;

      //print(data);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', data['tokens']['access']['token']);

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final user = User.fromJson(data['user']);
      UserLogged = user;
      print(UserLogged.name);
      await onSuccess(user);
    } on DioException catch (e) {
      //throw e;
    }
  }

  static Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'source': 'null',
        },
      );

      final data = response.data;

      print(data);
      if (response.statusCode != 201) {
        throw Exception(data['message']);
      }

      await onSuccess();
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> forgotPassword({
    required String email,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/user/forgotPassword',
        data: {
          'email': email,
        },
      );

      final data = response.data;

      print(data);

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      await onSuccess();
    } on DioException catch (e) {
      onError(e.response?.data['message']);
      //throw e;
    }
  }

  static loginByGoogle({
    required String accessToken,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/auth/google',
        data: {
          "access_token": accessToken,
        },
      );

      final data = response.data;
      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', data['tokens']['access']['token']);

      final user = User.fromJson(data['user']);
      UserLogged = user;
      UserLogged.avatar =
          "https://sandbox.api.lettutor.com/avatar/cb9e7deb-3382-48db-b07c-90acf52f541cavatar1686550060378.jpg";
      //print(UserLogged.name);
      //print(data);
      await onSuccess();
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static loginByFacebook({
    required String accessToken,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/auth/facebook',
        data: {
          'access_token': accessToken,
        },
      );

      final data = response.data;
      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', data['tokens']['access']['token']);

      final user = User.fromJson(data['user']);
      UserLogged = user;
      UserLogged.avatar =
          "https://sandbox.api.lettutor.com/avatar/cb9e7deb-3382-48db-b07c-90acf52f541cavatar1686550060378.jpg";

      await onSuccess();
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  // static loginByFacebook({
  //   required String accessToken,
  //   required Function(User, Tokens) onSuccess,
  // }) async {
  //   final response = await DioService().post(
  //     '/auth/facebook',
  //     data: {
  //       'access_token': accessToken,
  //     },
  //   );

  //   final data = json.decode(response.data);
  //   if (response.statusCode != 200) {
  //     throw Exception(data['message']);
  //   }

  //   final user = User.fromJson(data['user']);
  //   final tokens = Tokens.fromJson(data['tokens']);
  //   await onSuccess(user, tokens);
  // }

  // static Future<void> continueSession({
  //   required String refreshToken,
  //   required Function(User, Tokens) onSuccess,
  // }) async {
  //   final response = await DioService().post(
  //     '/auth/refresh-token',
  //     data: {
  //       'refreshToken': refreshToken,
  //       'timezone': "7",
  //     },
  //   );

  //   final data = json.decode(response.data);
  //   if (response.statusCode != 200) {
  //     throw Exception(data['message']);
  //   }

  //   final user = User.fromJson(data['user']);
  //   final token = Tokens.fromJson(data['tokens']);
  //   await onSuccess(user, token);
  // }

  // static Future<void> registerWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   final response = await DioService().post(
  //     '/auth/register',
  //     data: {
  //       'email': email,
  //       'password': password,
  //       'source': 'null',
  //     },
  //   );

  //   final data = json.decode(response.data);
  //   if (response.statusCode != 201) {
  //     throw Exception(data['message']);
  //   }
  // }

  // static Future<void> forgotPassword(String email) async {
  //   final response = await DioService().post(
  //     '/user/forgotPassword',
  //     data: {
  //       'email': email,
  //     },
  //   );

  //   final data = json.decode(response.data);
  //   if (response.statusCode != 200) {
  //     throw Exception(data['message']);
  //   }
  // }
}
