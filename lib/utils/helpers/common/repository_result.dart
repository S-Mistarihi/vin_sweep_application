import 'exception/repository_exception.dart';

sealed class RepositoryResult<T> {
  const RepositoryResult();
}

final class Success<T> extends RepositoryResult<T> {
  final T data;

  const Success(this.data);
}

final class Failure<T> extends RepositoryResult<T> {
  final RepositoryException exception;

  const Failure(this.exception);
}
