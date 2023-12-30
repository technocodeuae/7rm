import 'package:equatable/equatable.dart';
import 'package:sevin_rm/data/models/auctions/auction_calendar_model.dart';

abstract class StartBidStates extends Equatable {
  const StartBidStates();
}

class InitialStartBid extends StartBidStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LoadingStartBid extends StartBidStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SuccessStartBid extends StartBidStates{
  final bool isBid;
  const SuccessStartBid(this.isBid);
  @override
  // TODO: implement props
  List<Object?> get props => [isBid];
}
class ErrorStateStartBid extends StartBidStates{
  final String error;
  const ErrorStateStartBid(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}