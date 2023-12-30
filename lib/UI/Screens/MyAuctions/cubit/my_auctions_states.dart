import 'package:sevin_rm/data/models/auctions/all_my_auctions.dart';

//
abstract class MyAuctionsState {}

class InitialStatesMyAuctions extends MyAuctionsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingStatesMyAuctions extends MyAuctionsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessStatesMyAuctions extends MyAuctionsState {
  final MyAuctions myAuctions;
  SuccessStatesMyAuctions(this.myAuctions);
  // TODO: implement props
  List<Object?> get props => [myAuctions];
}

class ErrorStateMyAuctions extends MyAuctionsState {
  final String error;
  ErrorStateMyAuctions(this.error);
  @override
  List<Object?> get props => [error];
}
