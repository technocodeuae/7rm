import 'package:equatable/equatable.dart';
import 'package:sevin_rm/data/models/auctions/auction_calendar_model.dart';

abstract class AuctionsCheckerStates extends Equatable {
  const AuctionsCheckerStates();
}

abstract class AuctionsCalendarStates extends Equatable {
  const AuctionsCalendarStates();
}

class InitialCalendar extends AuctionsCalendarStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LoadingCalendar extends AuctionsCalendarStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SuccessCalendar extends AuctionsCalendarStates{
  final AuctionCalendarModel calendars;
  const SuccessCalendar(this.calendars);
  @override
  // TODO: implement props
  List<Object?> get props => [calendars];
}
class ErrorStateCalendar extends AuctionsCalendarStates{
  final String error;
  const ErrorStateCalendar(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}



class InitialCheck extends AuctionsCalendarStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LoadingCheck extends AuctionsCalendarStates{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SuccessCheck extends AuctionsCalendarStates{
  final bool checked;
  final int index;
  const SuccessCheck(this.checked,this.index);
  @override
  // TODO: implement props
  List<Object?> get props => [checked,index];
}
class ErrorStateCheck extends AuctionsCalendarStates{
  final String error;
  const ErrorStateCheck(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}