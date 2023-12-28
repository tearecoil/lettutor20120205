import 'package:dio/dio.dart';
import 'package:lettutor20120205/models/tutor/tutor_review.dart';
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
          'country': updateUser?.country,
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

  static Future<void> reportTutor({
    required String userId,
    required String content,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/report',
        data: {
          'tutorId': userId,
          'content': content,
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      await onSuccess();
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> getTutorFeedback({
    required int page,
    required int perPage,
    required String userId,
    required Function(List<ReviewTutor>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/feedback/v2/$userId?perPage=$perPage&page=$page',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final List<dynamic> feedbacks = data['data']['rows'];

      final feedbackList = feedbacks
          .map<ReviewTutor>((feedback) => ReviewTutor.fromJson(feedback))
          .toList();

      await onSuccess(feedbackList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<String?> feedbackTutor({
    required String bookingId,
    required String content,
    required int rating,
    required String userId,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/user/feedbackTutor',
        data: {
          'bookingId': bookingId,
          'content': content,
          'rating': rating,
          'userId': userId,
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      return await onSuccess();
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }

    return null;
  }
}
