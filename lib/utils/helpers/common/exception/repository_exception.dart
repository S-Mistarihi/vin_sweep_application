sealed class RepositoryException implements Exception {
  final String message;
  final String? errorCode;
  final Object? cause;
  final StackTrace? stackTrace;

  const RepositoryException(
    this.message, {
    this.cause,
    this.stackTrace,
    this.errorCode,
  });

  @override
  String toString() {
    return message;
  }
}

final class NetworkException extends RepositoryException {
  const NetworkException(
    super.message, {
    super.cause,
    super.errorCode,
    super.stackTrace,
  });
}

final class TimeoutException extends RepositoryException {
  const TimeoutException(
    super.message, {
    super.cause,
    super.errorCode,
    super.stackTrace,
  });
}

final class HttpException extends RepositoryException {
  final int statusCode;

  const HttpException(
    super.message, {
    required this.statusCode,
    super.cause,
    super.errorCode,
    super.stackTrace,
  });
}

final class ParsingException extends RepositoryException {
  const ParsingException(
    super.message, {
    super.cause,
    super.errorCode,
    super.stackTrace,
  });
}

final class MappingException extends RepositoryException {
  const MappingException(
    super.message, {
    super.cause,
    super.errorCode,
    super.stackTrace,
  });
}

final class UnknownException extends RepositoryException {
  const UnknownException(
    super.message, {
    super.cause,
    super.errorCode,
    super.stackTrace,
  });
}

final class FirebaseAuthRegisteration extends RepositoryException {
  const FirebaseAuthRegisteration(
    super.message, {
    super.cause,
    super.errorCode,
    super.stackTrace,
  });
}
