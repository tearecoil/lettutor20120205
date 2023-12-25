import 'package:dio/dio.dart';
import 'package:lettutor20120205/models/course-topic/learn_topic.dart';
import 'package:lettutor20120205/models/course-topic/test_preparation.dart';
import 'package:lettutor20120205/service-api/dio.dart';

class DataService {
  static Future<void> getTestPreparation({
    required Function(List<TestPreparation>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/test-preparation',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final testPreparationList = data
          .map<TestPreparation>(
              (testPreparation) => TestPreparation.fromJson(testPreparation))
          .toList();
      await onSuccess(testPreparationList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> getTopic({
    required Function(List<LearnTopic>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/learn-topic',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final topicList =
          data.map<LearnTopic>((topic) => LearnTopic.fromJson(topic)).toList();
      await onSuccess(topicList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }
}
