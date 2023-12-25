import 'package:dio/dio.dart';
import 'package:lettutor20120205/models/tutor/tutor_api.dart';
import 'package:lettutor20120205/models/tutor/tutor_info.dart';
import 'package:lettutor20120205/service-api/dio.dart';

class TutorService {
  static Future<void> getListTutorWithPagination({
    required int page,
    required int perPage,
    required Function(List<Tutor_api>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/tutor/more?perPage=$perPage&page=$page',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final List<dynamic> tutors = data['tutors']['rows'];

      await onSuccess(
          tutors.map<Tutor_api>((tutor) => Tutor_api.fromJson(tutor)).toList());
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> getTutorInformation({
    required String tutorID,
    required Function(TutorInfo) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/tutor/$tutorID',
      );
      final data = response.data;
      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }
      await onSuccess(TutorInfo.fromJson(data));
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> getTutorwithFilters({
    required int page,
    required int perPage,
    String search = '',
    Map<String, bool> nationality = const <String, bool>{},
    List<String> specialties = const <String>[],
    required Function(List<Tutor_api>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/tutor/search',
        data: {
          'page': page,
          'perPage': perPage,
          'search': search,
          'filters': {
            'specialties': specialties,
            'nationality': nationality,
          },
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final List<dynamic> tutors = data['rows'];

      final tutorList =
          tutors.map((tutor) => Tutor_api.fromJson(tutor)).toList();

      await onSuccess(tutorList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> addFavorite({
    required String userId,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().post(
        '/user/manageFavoriteTutor',
        data: {
          'tutorId': userId,
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
}
