import 'package:sevin_rm/data/models/booking/all_booking.dart';
import 'package:sevin_rm/data/models/stables/stable_trainers_model.dart';

import '../../../../data/models/categories/categories_model.dart';
import '../../../../data/models/categories/stables_services_package_model.dart';
import '../../../../data/models/stables/best_stables_model.dart';
import '../../../../data/models/stables/stable_nearby_model.dart';
import '../../../../data/models/stables/stables_information.dart';
import '../../../../data/models/stables/stables_model.dart';
import 'package:fl_location/fl_location.dart';
import 'package:android_intent_plus/android_intent.dart';

abstract class AppCubitMainPageStates {}

class AppMainPageInitialStates extends AppCubitMainPageStates {}

class GetAllStablesLoadingStates extends AppCubitMainPageStates {}

class GetAllStablesSuccessStates extends AppCubitMainPageStates {
  final StablesModel stablesModel;
  GetAllStablesSuccessStates(this.stablesModel);
  // TODO: implement props
  List<Object?> get props => [stablesModel];
}

class GetAllStablesErrorStates extends AppCubitMainPageStates {
  final String error;
  GetAllStablesErrorStates(this.error);
  // TODO: implement props
  List<Object?> get props => [error];
}

class GetAllBookingLoadingStates extends AppCubitMainPageStates {}

class GetAllBookingSuccessStates extends AppCubitMainPageStates {
  final AllBookingModel? allBookingModel;
  GetAllBookingSuccessStates(this.allBookingModel);
  // TODO: implement props
  List<Object?> get props => [allBookingModel];
}

class GetAllBookingErrorStates extends AppCubitMainPageStates {
  final String error;
  GetAllBookingErrorStates(this.error);
  // TODO: implement props
  List<Object?> get props => [error];
}

class GetBestStablesLoadingStates extends AppCubitMainPageStates {}

class GetBestStablesSuccessStates extends AppCubitMainPageStates {
  final BestStablesModel bestStablesModel;
  GetBestStablesSuccessStates(this.bestStablesModel);
  // TODO: implement props
  List<Object?> get props => [bestStablesModel];
}

class GetBestStablesErrorStates extends AppCubitMainPageStates {
  final String? error;
  GetBestStablesErrorStates(this.error);
  // TODO: implement props
  List<Object?> get props => [error];
}

class GetNearbyStablesInitialState extends AppCubitMainPageStates {}

class GetNearbyStablesLoadingStates extends AppCubitMainPageStates {}

class GetNearbyStablesSuccessStates extends AppCubitMainPageStates {
  final StablesNearbyModel stablesNearbyModel;
  GetNearbyStablesSuccessStates(this.stablesNearbyModel);
  // TODO: implement props
  List<Object?> get props => [stablesNearbyModel];
}

class GetNearbyStablesErrorStates extends AppCubitMainPageStates {
  final String? error;
  GetNearbyStablesErrorStates(this.error);
  // TODO: implement props
  List<Object?> get props => [error];
}

class GetCategoriesDataLoadingStates extends AppCubitMainPageStates {}

class GetCategoriesDataSuccessStates extends AppCubitMainPageStates {
  final CategoriesModel categoriesModel;
  GetCategoriesDataSuccessStates(this.categoriesModel);
  // TODO: implement props
  List<Object?> get props => [categoriesModel];
}

class GetCategoriesDataErrorStates extends AppCubitMainPageStates {
  final String? error;
  GetCategoriesDataErrorStates(this.error);
  // TODO: implement props
  List<Object?> get props => [error];
}


class GetCategoriesIncludeDataLoadingStates extends AppCubitMainPageStates {}

class GetCategoriesIncludeDataSuccessStates extends AppCubitMainPageStates {
  final StablesPackagesServicesCategoryModel categoriesIncludeModel;
  GetCategoriesIncludeDataSuccessStates(this.categoriesIncludeModel);
  // TODO: implement props
  List<Object?> get props => [categoriesIncludeModel];
}

class GetCategoriesIncludeDataErrorStates extends AppCubitMainPageStates {
  final String? error;
  GetCategoriesIncludeDataErrorStates(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class GetStableTrainersLoadingStates extends AppCubitMainPageStates {}

class GetStableTrainersSuccessStates extends AppCubitMainPageStates {
  final StableTrainersModel stableTrainersModel;
  GetStableTrainersSuccessStates(this.stableTrainersModel);
  // TODO: implement props
  List<Object?> get props => [stableTrainersModel];
}

class GetStableTrainersErrorStates extends AppCubitMainPageStates {
  final String? error;
  GetStableTrainersErrorStates(this.error);
  // TODO: implement props
  List<Object?> get props => [error];
}
