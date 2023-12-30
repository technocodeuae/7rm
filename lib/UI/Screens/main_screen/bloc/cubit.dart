import 'package:android_intent_plus/android_intent.dart';
import 'package:bloc/src/cubit.dart';
import 'package:fl_location/fl_location.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:sevin_rm/Core/di/di_manager.dart';
import 'package:sevin_rm/Core/shared_prefs/shared_prefs.dart';
import 'package:sevin_rm/UI/Screens/main_screen/bloc/states.dart';
import 'package:sevin_rm/core/results/result.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../data/models/booking/all_booking.dart';
import '../../../../data/models/categories/categories_model.dart';
import '../../../../data/models/categories/stables_services_package_model.dart';
import '../../../../data/models/stables/best_stables_model.dart';
import '../../../../data/models/stables/stable_nearby_model.dart';
import '../../../../data/models/stables/stable_trainers_model.dart';
import '../../../../data/models/stables/stables_information.dart';
import '../../../../data/models/stables/stables_model.dart';
import '../../../../data/sources/categories/categories_data_source.dart';
import '../../../../data/sources/stables/stables_data_source.dart';
import 'package:permission_handler/permission_handler.dart';

class AppCubitMainPage extends Cubit<AppCubitMainPageStates> {
  AppCubitMainPage() : super(AppMainPageInitialStates());

  static AppCubitMainPage get(context) => BlocProvider.of(context);

  Future<void> getAllStables() async {
    StablesRemoteDataSourceImpl stablesRemoteDataSourceImpl =
        StablesRemoteDataSourceImpl();
    try {
      emit(GetAllStablesLoadingStates());

      Result<StablesModel> stablesData =
          await stablesRemoteDataSourceImpl.geAllStables();

      print("Error ===> ${stablesData.error?.message}");
      print("=========\nData ===> ${stablesData.data}");
      if (stablesData.data != null) {
        emit(GetAllStablesSuccessStates(stablesData.data as StablesModel));
      } else {
        emit(GetAllStablesErrorStates(stablesData.error.toString()));
      }
    } catch (e, stack) {
      print("Error In Login is : $e in $stack");
      emit(GetAllStablesErrorStates(e.toString()));
    }
  }

  AllBookingModel? allBookingModel;
  Future<void> getAllBooking() async {
    StablesRemoteDataSourceImpl stablesRemoteDataSourceImpl =
    StablesRemoteDataSourceImpl();
    try {
      emit(GetAllBookingLoadingStates());

      Result<AllBookingModel> bookingData =
      await stablesRemoteDataSourceImpl.getAllBooking();

      print("Error ===> ${bookingData.error?.message}");
      print("=========\nData ===> ${bookingData.data}");
      if (bookingData.data != null) {
        emit(GetAllBookingSuccessStates(bookingData.data));
        allBookingModel = bookingData.data;
        print('78712876782163872673278678238732873637863283762332876387326328763278632763768223836');
        print(allBookingModel?.message);
      } else {
        emit(GetAllBookingErrorStates(bookingData.error.toString()));
      }
    } catch (e, stack) {
      print("Error In Login is : $e in $stack");
      emit(GetAllBookingErrorStates(e.toString()));
    }
  }


  Future<void> getBestStables() async {
    StablesRemoteDataSourceImpl stablesRemoteDataSourceImpl =
        StablesRemoteDataSourceImpl();
    try {
      emit(GetBestStablesLoadingStates());

      Result<BestStablesModel> stablesData =
          await stablesRemoteDataSourceImpl.getBestStables();

      print("Error ===> ${stablesData.error?.message}");
      print("=========\nData ===> ${stablesData.data}");
      if (stablesData.data != null) {
        emit(GetBestStablesSuccessStates(stablesData.data as BestStablesModel));
      } else {
        emit(GetBestStablesErrorStates(stablesData.error.toString()));
      }
    } catch (e, stack) {
      print("Error In GetBestStables is : $e in $stack");
      emit(GetBestStablesErrorStates(e.toString()));
    }
  }

  Future<void> getNearbyStables() async {
    StablesRemoteDataSourceImpl stablesRemoteDataSourceImpl =
        StablesRemoteDataSourceImpl();
    try {
      emit(GetNearbyStablesLoadingStates());
        Result<StablesNearbyModel> stablesData =
        await stablesRemoteDataSourceImpl.getNearbyStables();
        print("Error ===> ${stablesData.error?.message}");
        print("=========\nData ===> ${stablesData.data}");
        if (stablesData.data != null) {
          emit(GetNearbyStablesSuccessStates(stablesData.data as StablesNearbyModel));
        } else {
          emit(GetNearbyStablesErrorStates(stablesData.error.toString()));
        }
      } catch (e, stack) {
      print("Error In GetNearbyStables is : $e in $stack");
      emit(GetNearbyStablesErrorStates(e.toString()));
    }
  }

  Future<void> getNearbyStablesLocation(LatLng? latLng) async {
    StablesRemoteDataSourceImpl stablesRemoteDataSourceImpl =
    StablesRemoteDataSourceImpl();
    try {
      emit(GetNearbyStablesLoadingStates());

      Location? getMyLocation = await GetMyLocation();
      print("========> result of Location is : $getMyLocation");
      if(getMyLocation==null){
        emit(GetNearbyStablesErrorStates("Location Invalid"));
      }
      else{

        DIManager.findDep<SharedPrefs>().setMyLocationLat(getMyLocation.latitude);
        DIManager.findDep<SharedPrefs>().setMyLocationLang(getMyLocation.longitude);

        Result<StablesNearbyModel> stablesData =
        latLng == null ?
        await stablesRemoteDataSourceImpl.
        getNearbyStablesLocations(getMyLocation.longitude, getMyLocation.latitude)
        :await stablesRemoteDataSourceImpl.
        getNearbyStablesLocations(latLng.longitude, latLng.latitude);
        print("Error ===> ${stablesData.error?.message}");
        print("=========\nData ===> ${stablesData.data}");
        if (stablesData.data != null) {
          emit(GetNearbyStablesSuccessStates(stablesData.data as StablesNearbyModel));
        } else {
          emit(GetNearbyStablesErrorStates(stablesData.error.toString()));
        }
      }
    } catch (e, stack) {
      print("Error In Get NearbyLocation is : $e in $stack");
      emit(GetNearbyStablesErrorStates(e.toString()));
    }
  }

  Future<bool?> checkAndRequestPermission({bool? background}) async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      // Location permission is denied, request permission
      var result = await Permission.location.request();

      if (result == PermissionStatus.granted) {
        // Location permission granted
        return true;
      } else {
        // Location permission denied by the user
        // You can display a message or UI to inform the user to enable location
        return false;
      }
    } else {
      // Location permission is already granted
      return true;
    }
  }

  Future<Location?> GetMyLocation() async {
    bool? checkPermission = await checkAndRequestPermission();
   if (checkPermission!=null&&checkPermission) {
      const timeLimit = Duration(seconds: 20);
      return await FlLocation.getLocation(timeLimit: timeLimit).onError((error, stackTrace) {
        print('error: ${error.toString()}');
        return error as Location;
      });
    }
   else {
    print("Error in My Location");
    return null;
  }
  }

  DataCategoriesModel? dataCategoriesModel;
  Future<void> getAllCategories() async {
    CategoriesRemoteDataSourceImpl categoriesRemoteDataSourceImpl =
        CategoriesRemoteDataSourceImpl();
    try {
      emit(GetCategoriesDataLoadingStates());

      Result<CategoriesModel> categoriesData =
          await categoriesRemoteDataSourceImpl.getAllCategories();

      // print("CategoriesError ===> ${categoriesData.error?.message}");
      // print("=========\nCategoriesData ===> ${categoriesData.data}");

      if (categoriesData.data != null) {
        emit(GetCategoriesDataSuccessStates(categoriesData.data!));
        dataCategoriesModel = categoriesData.data!.data;
        print(categoriesData.data);
      } else {
        emit(GetCategoriesDataErrorStates(categoriesData.error.toString()));
      }
    } catch (e, stack) {
      print("Error In getIndexCategories is : $e in $stack");
      emit(GetCategoriesDataErrorStates(e.toString()));
    }

// void geAllStables() {
    //   emit(GetAllStablesLoadingStates());
    //   DioHelper.getData(
    //     url: AppEndpoints.baseUrl+AppEndpoints.indexStables,
    //   ).then((value) {
    //     emit(GetAllStablesSuccessStates());
    //     stablesModel = StablesModel.fromJson(value.data);
    //     print(stablesModel!.message);
    //   }).catchError((onError) {
    //     print(onError.toString());
    //     emit(GetAllStablesErrorStates());
    //   });
    // }
  }

  Future<void> getIncludeCategory({required int categoryId}) async {
    CategoriesRemoteDataSourceImpl categoriesRemoteDataSourceImpl =
        CategoriesRemoteDataSourceImpl();
    try {
      emit(GetCategoriesIncludeDataLoadingStates());

      Result<StablesPackagesServicesCategoryModel> categoriesData =
          await categoriesRemoteDataSourceImpl.getIncludeCategory(
              categoryId: categoryId);

      // print("CategoriesError ===> ${categoriesData.error?.message}");
      // print("=========\nCategoriesData ===> ${categoriesData.data}");

      if (categoriesData.data != null) {
        emit(GetCategoriesIncludeDataSuccessStates(categoriesData.data!));
      } else {
        emit(GetCategoriesIncludeDataErrorStates(
            categoriesData.error.toString()));
      }
    } catch (e, stack) {
      print("Error In getIndexCategories is : $e in $stack");
      emit(GetCategoriesIncludeDataErrorStates(e.toString()));
    }

// void geAllStables() {
    //   emit(GetAllStablesLoadingStates());
    //   DioHelper.getData(
    //     url: AppEndpoints.baseUrl+AppEndpoints.indexStables,
    //   ).then((value) {
    //     emit(GetAllStablesSuccessStates());
    //     stablesModel = StablesModel.fromJson(value.data);
    //     print(stablesModel!.message);
    //   }).catchError((onError) {
    //     print(onError.toString());
    //     emit(GetAllStablesErrorStates());
    //   });
    // }
  }

  Future<void> getStableTrainers() async {
    StablesRemoteDataSourceImpl stablesRemoteDataSourceImpl =
        StablesRemoteDataSourceImpl();
    try {
      emit(GetStableTrainersLoadingStates());

      Result<StableTrainersModel> stablesTrainersData =
          await stablesRemoteDataSourceImpl.getStableTrainers();

      print("Error ===> ${stablesTrainersData.error?.message}");
      print("=========\nData ===> ${stablesTrainersData.data}");
      if (stablesTrainersData.data != null) {
        emit(GetStableTrainersSuccessStates(
            stablesTrainersData.data as StableTrainersModel));
      } else {
        emit(
            GetStableTrainersErrorStates(stablesTrainersData.error.toString()));
      }
    } catch (e, stack) {
      print("Error In Login is : $e in $stack");
      emit(GetStableTrainersErrorStates(e.toString()));
    }
  }


}
