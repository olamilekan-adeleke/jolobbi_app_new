part of 'log_trans_bloc.dart';

abstract class LogTransEvent extends Equatable {
  const LogTransEvent();

  @override
  List<Object> get props => [];
}

class LogFlutterWaveTransEvent extends LogTransEvent {
  final Map<String, dynamic> data;
  const LogFlutterWaveTransEvent(this.data);

  @override
  List<Object> get props => [data];
}

class LogPaystackTransEvent extends LogTransEvent {
  final Map<String, dynamic> data;
  const LogPaystackTransEvent(this.data);

  @override
  List<Object> get props => [data];
}
