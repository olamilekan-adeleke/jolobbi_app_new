import 'dart:developer' as developer;

class LoggerHelper{

  static log(e, [s = '']){
    developer.log(e.toString());
    developer.log(s.toString());
  }
}