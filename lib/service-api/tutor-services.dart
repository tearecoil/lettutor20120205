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
}
