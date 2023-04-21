part of 'confirm_make_payment_bloc.dart';

class ConfirmMakePaymentEvent extends Equatable {
  final String orderId;
  const ConfirmMakePaymentEvent(this.orderId);

  @override
  List<Object> get props => [orderId];
}
