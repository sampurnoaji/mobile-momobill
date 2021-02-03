class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class ServerException extends AppException {
  ServerException([message]) : super(message, "Server Problem: ");
}

class ClientException extends AppException {
  ClientException([message]) : super(message, "Client Problem: ");
}
