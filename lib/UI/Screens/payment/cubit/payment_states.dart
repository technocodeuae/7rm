import 'package:equatable/equatable.dart';


abstract class PaymentStates extends Equatable {
  const PaymentStates();
}
class InitialPayment extends PaymentStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LoadingPayment extends PaymentStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SuccessPayment extends PaymentStates{
  final bool payment;
  const SuccessPayment(this.payment);
  @override
  // TODO: implement props
  List<Object?> get props => [payment];
}
class ErrorStatePayment extends PaymentStates{
  final String error;
  const ErrorStatePayment(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}