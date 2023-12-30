import 'package:equatable/equatable.dart';

import '../../../../data/models/auctions/all_auctions.dart';
import '../../../../data/models/auctions/all_auctions_today.dart';

//
abstract class AuctionsStates extends Equatable {
  const AuctionsStates();
}

class InitialAuctions extends AuctionsStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingAuctions extends AuctionsStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessAuctions extends AuctionsStates {
  final AllAuctions auctions;
  const SuccessAuctions(this.auctions);
  @override
  // TODO: implement props
  List<Object?> get props => [auctions];
}

class ErrorStateAuctions extends AuctionsStates {
  final String error;
  const ErrorStateAuctions(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class InitialAuctionsToday extends AuctionsStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingAuctionsToday extends AuctionsStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuccessAuctionsToday extends AuctionsStates {
  final AuctionsToday today;
  const SuccessAuctionsToday(this.today);
  @override
  // TODO: implement props
  List<Object?> get props => [today];
}

class ErrorStateAuctionsToday extends AuctionsStates {
  final String error;
  const ErrorStateAuctionsToday(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
