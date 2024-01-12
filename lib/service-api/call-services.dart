import 'package:dio/dio.dart';
import 'package:lettutor20120205/service-api/dio.dart';

class CallService {
  static Future<void> getTotalCall({
    required Function(int) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await DioService().get(
        '/call/total',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final total = data['total'];

      await onSuccess(total);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }
}
