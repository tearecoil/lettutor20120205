import 'package:dio/dio.dart';
import 'package:lettutor20120205/models/user/User.dart';
import 'package:lettutor20120205/service-api/dio.dart';

class UserService {
  static Future<void> updateInfo({
    User? updateUser,
    required Function(User?) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().put(
        '/user/info',
        data: {
          'name': updateUser?.name,
          'requireNote': updateUser?.requireNote,
          'birthday': updateUser?.birthday,
          'language': updateUser?.language,
          'level': updateUser?.level,
          'avatar': updateUser?.avatar,
        },
      );

      final data = response.data;
      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final user = User.fromJson(data['user']);
      await onSuccess(user);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }
}
