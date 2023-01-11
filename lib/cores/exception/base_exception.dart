import '../failures/base.dart';

class BaseException extends Failures {
  const BaseException({required String message, StackTrace? trace})
      : super(message: message, trace: trace);
}
