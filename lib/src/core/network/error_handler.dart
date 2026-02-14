import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'failure.dart';

/// API status mapping
enum ApiStatus {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultStatus,
  unProcessableData,
  notImplemented,
  badGateway,
  serviceUnavailable,
}

/// Extension to convert ApiStatus → Failure
extension ApiStatusX on ApiStatus {
  Failure getFailure() {
    switch (this) {
      case ApiStatus.badRequest:
        return const Failure(code: 400, message: 'Bad request');

      case ApiStatus.unauthorised:
        return const Failure(code: 401, message: 'Unauthorized');

      case ApiStatus.forbidden:
        return const Failure(code: 403, message: 'Forbidden');

      case ApiStatus.notFound:
        return const Failure(code: 404, message: 'Not found');

      case ApiStatus.connectTimeout:
        return const Failure(code: 408, message: 'Connection timeout');

      case ApiStatus.receiveTimeout:
        return const Failure(code: -4, message: 'Receive timeout');

      case ApiStatus.sendTimeout:
        return const Failure(code: -5, message: 'Send timeout');

      case ApiStatus.cancel:
        return const Failure(code: -3, message: 'Request cancelled');

      case ApiStatus.unProcessableData:
        return const Failure(code: 422, message: 'Unprocessable content');

      case ApiStatus.internalServerError:
        return const Failure(code: 500, message: 'Internal server error');

      case ApiStatus.notImplemented:
        return const Failure(code: 501, message: 'Not implemented');

      case ApiStatus.badGateway:
        return const Failure(code: 502, message: 'Bad gateway');

      case ApiStatus.serviceUnavailable:
        return const Failure(code: 503, message: 'Service unavailable');

      case ApiStatus.noInternetConnection:
        return const Failure(code: -7, message: 'No internet connection');

      default:
        return const Failure(code: -1, message: 'Something went wrong');
    }
  }
}

/// Centralized Dio error handler
Failure handleDioError(DioException error) {
  if (kDebugMode) {
    log('❌ Dio error: ${error.message}');
  }

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return ApiStatus.connectTimeout.getFailure();

    case DioExceptionType.sendTimeout:
      return ApiStatus.sendTimeout.getFailure();

    case DioExceptionType.receiveTimeout:
      return ApiStatus.receiveTimeout.getFailure();

    case DioExceptionType.cancel:
      return ApiStatus.cancel.getFailure();

    case DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode;

      switch (statusCode) {
        case 400:
          return ApiStatus.badRequest.getFailure();
        case 401:
          return ApiStatus.unauthorised.getFailure();
        case 403:
          return ApiStatus.forbidden.getFailure();
        case 404:
          return ApiStatus.notFound.getFailure();
        case 408:
          return ApiStatus.connectTimeout.getFailure();
        case 422:
          return ApiStatus.unProcessableData.getFailure();
        case 500:
          return ApiStatus.internalServerError.getFailure();
        case 501:
          return ApiStatus.notImplemented.getFailure();
        case 502:
          return ApiStatus.badGateway.getFailure();
        case 503:
          return ApiStatus.serviceUnavailable.getFailure();
        default:
          return ApiStatus.defaultStatus.getFailure();
      }

    case DioExceptionType.badCertificate:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      return ApiStatus.noInternetConnection.getFailure();
  }
}
