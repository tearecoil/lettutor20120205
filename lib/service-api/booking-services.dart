import 'package:dio/dio.dart';
import 'package:lettutor20120205/models/schedule/booking_info.dart';
import 'package:lettutor20120205/models/schedule/schedule_api.dart';
import 'package:lettutor20120205/models/tutor/tutor_api.dart';
import 'package:lettutor20120205/models/tutor/tutor_info.dart';
import 'package:lettutor20120205/models/tutor/tutor_review.dart';
import 'package:lettutor20120205/service-api/dio.dart';

class BookingService {
  static final DioService _dioService = DioService();

  static Future<void> getTutorScheduleById({
    required String userID,
    required Function(List<Schedule_api>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.post(
        '/schedule',
        data: {
          'tutorId': userID,
        },
      );

      final data = response.data;
      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final schedules = data['data'];

      final scheduleList = schedules
          .map<Schedule_api>((schedule) => Schedule_api.fromJson(schedule))
          .toList();
      await onSuccess(scheduleList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> getTutorNextBookingList({
    required Function(List<BookingInfo>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.get(
        '/booking/next',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final bookings = data['data'];

      final bookingList = bookings
          .map<BookingInfo>((booking) => BookingInfo.fromJson(booking))
          .toList();

      await onSuccess(bookingList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> bookClass({
    required List<String> scheduleDetailIds,
    required String note,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.post(
        '/booking',
        data: {
          'scheduleDetailIds': scheduleDetailIds,
          'note': note,
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

  static Future<void> getBookingListByStudent({
    required int page,
    required int perPage,
    int inFuture = 1,
    String orderBy = 'meeting',
    String sortBy = 'asc',
    required Function(List<BookingInfo>) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.get(
        '/booking/list/student?page=$page&perPage=$perPage&inFuture=$inFuture&orderBy=$orderBy&sortBy=$sortBy',
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      final bookingInfo = data['data']['rows'];

      final bookingList = bookingInfo
          .map<BookingInfo>((booking) => BookingInfo.fromJson(booking))
          .toList();
      await onSuccess(bookingList);
    } on DioException catch (e) {
      onError(e.response?.data['message']);
    }
  }

  static Future<void> handleBookingStudentRequest({
    required String bookingId,
    required String studentRequest,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final response = await _dioService.post(
        '/booking/student-request/$bookingId',
        data: {
          'studentRequest': studentRequest,
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

  static Future<bool?> cancelBooking({
    required int cancelReasonId,
    String? cancelNote,
    required String scheduleDetailId,
  }) async {
    try {
      final response = await _dioService.delete(
        '/booking/schedule-detail',
        data: {
          'cancelInfo': {
            'cancelReasonId': cancelReasonId,
            'note': cancelNote,
          },
          'scheduleDetailId': scheduleDetailId,
        },
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      return true;
    } on DioException {
      return false;
    }
  }
}
