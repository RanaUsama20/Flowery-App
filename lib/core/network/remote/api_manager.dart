import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../../../generated/locale_keys.g.dart';
import '../common/api_result.dart';
import 'app_exception.dart';

@singleton
class ApiManager {
  Future<Result<T>> execute<T>(Future<T> Function() apiCall) async {
    try {
      final response = await apiCall();
      return SuccessResult<T>(response);
    } on SocketException {
      return FailureResult<T>(
        InternetConnectionException(
            message: LocaleKeys.Error_NoInternetConnection.tr()),
      );
    } on DioException catch (e) {
      return _handleDioException<T>(e);
    } on FormatException {
      return FailureResult<T>(
        DataParsingException(
            message: LocaleKeys.Error_DataParsingException.tr()),
      );
    } catch (e) {
      return FailureResult<T>(
        UnknownApiException(message: LocaleKeys.Error_Unexpected_error.tr()),
      );
    }
  }

  Result<T> _handleDioException<T>(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return FailureResult<T>(
          ApiTimeoutException(message: _getTimeoutMessage(e.type)),
        );
      case DioExceptionType.badCertificate:
        return FailureResult<T>(
          CertificateException(
              message: LocaleKeys.Error_Invalid_certificate.tr()),
        );
      case DioExceptionType.badResponse:
        if (e.response == null) {
          return FailureResult<T>(UnknownApiException(
              message: LocaleKeys.Error_Unexpected_server_error.tr()));
        }
        return _handleBadResponse<T>(e.response!);
      case DioExceptionType.cancel:
        return FailureResult<T>(
          RequestCancelledException(
              message: LocaleKeys.Error_Request_cancelled.tr()),
        );
      case DioExceptionType.connectionError:
        return FailureResult<T>(
          InternetConnectionException(
              message: LocaleKeys.Error_Connection_failed.tr()),
        );
      case DioExceptionType.unknown:
        return FailureResult<T>(
          UnknownApiException(
              message: e.message ?? LocaleKeys.Error_Unexpected_error.tr()),
        );
    }
  }

  Result<T> _handleBadResponse<T>(Response response) {
    final statusCode = response.statusCode ?? 500;
    final errorMessage = _extractErrorMessage(response.data);

    switch (statusCode) {
      case 400:
        return FailureResult<T>(
          BadRequestException(message: errorMessage, statusCode: statusCode),
        );
      case 401:
        return FailureResult<T>(
          UnauthorizedException(message: errorMessage, statusCode: statusCode),
        );
      case 403:
        return FailureResult<T>(
          ForbiddenException(message: errorMessage, statusCode: statusCode),
        );
      case 404:
        return FailureResult<T>(
          NotFoundException(message: errorMessage, statusCode: statusCode),
        );
      case 500:
        return FailureResult<T>(
          InternalServerErrorException(
            message: errorMessage,
            statusCode: statusCode,
          ),
        );
      default:
        return FailureResult<T>(
          UnknownApiException(
              message: 'Unexpected error: $statusCode - $errorMessage'),
        );
    }
  }

  String _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['error']?.toString() ??
          LocaleKeys.Error_Unexpected_server_error.tr();
    }
    return data.toString();
  }

  String _getTimeoutMessage(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return LocaleKeys.Error_Connection_timeout.tr();
      case DioExceptionType.sendTimeout:
        return LocaleKeys.Error_Send_timeout.tr();
      case DioExceptionType.receiveTimeout:
        return LocaleKeys.Error_Receive_timeout.tr();
      default:
        return LocaleKeys.Error_Timeout_occurred.tr();
    }
  }
}
