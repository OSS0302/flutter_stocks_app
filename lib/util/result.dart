abstract class Result<T>{
  factory Result.success(T data) = Success;
  factory Result.error(Exception e) = Error;
}

class Success<T> implements Result<T>{
  // 성공시에는 T 데이터를 가진다.
  final T data;

  Success(this.data);
}

class Error<T> implements Result<T>{
 // 에러 exception e 가진다.
  final Exception e;

  Error(this.e);
}