enum ApiStatus { loading, success, failed }

class Resource<T> {
  final ApiStatus status;
  final T data;
  final String message;

  Resource({this.status, this.data, this.message});

  factory Resource.loading() => Resource<T>(status: ApiStatus.loading);

  factory Resource.success(T data) =>
      Resource<T>(status: ApiStatus.success, data: data);

  factory Resource.failed(String message) =>
      Resource<T>(status: ApiStatus.failed, message: message);
}
