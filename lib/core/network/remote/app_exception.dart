abstract class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class InternetConnectionException extends ApiException {
  const InternetConnectionException({
    required super.message,
  });
}

class ApiTimeoutException extends ApiException {
  const ApiTimeoutException({
    required super.message,
  });
}

class BadRequestException extends ApiException {
  const BadRequestException({
    required super.message,
    super.statusCode,
  });
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    required super.message,
    super.statusCode,
  });
}

class ForbiddenException extends ApiException {
  const ForbiddenException({
    required super.message,
    super.statusCode,
  });
}

class NotFoundException extends ApiException {
  const NotFoundException({
    required super.message,
    super.statusCode,
  });
}

class InternalServerErrorException extends ApiException {
  const InternalServerErrorException({
    required super.message,
    super.statusCode,
  });
}

class CertificateException extends ApiException {
  CertificateException({
    required super.message,
  });
}

class RequestCancelledException extends ApiException {
  const RequestCancelledException({
    required super.message,
  });
}

class UnknownApiException extends ApiException {
  const UnknownApiException({
    required super.message,
  });
}

class DataParsingException extends ApiException {
  const DataParsingException({
    required super.message,
  });
}
