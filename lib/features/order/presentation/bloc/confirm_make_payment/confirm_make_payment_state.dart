part of 'confirm_make_payment_bloc.dart';

abstract class ConfirmMakePaymentState extends Equatable {
  const ConfirmMakePaymentState();

  @override
  List<Object> get props => [];
}

class ConfirmMakePaymentInitial extends ConfirmMakePaymentState {}

class ConfirmMakePaymentLoading extends ConfirmMakePaymentState {}

class ConfirmMakePaymentError extends ConfirmMakePaymentState {
  final String message;
  const ConfirmMakePaymentError(this.message);

  @override
  List<Object> get props => [message];
}

class ConfirmMakePaymentSuccess extends ConfirmMakePaymentState {
  final BaseEntity entity;
  const ConfirmMakePaymentSuccess(this.entity);

  @override
  List<Object> get props => [entity];
}
