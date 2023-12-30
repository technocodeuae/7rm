import 'package:sevin_rm/core/net/http_method.dart';
import 'package:sevin_rm/data/models/booking/booking_availabel_times.dart';
import 'package:sevin_rm/data/models/booking/booking_user_stable.dart';

import '../../../../core/results/result.dart';
import '../../../Core/data_source/base_remote_data_source.dart';
import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../models/booking/add_order_model.dart';
import '../../models/booking/booking_package.dart';
import '../../models/booking/booking_with_packages.dart';
import '../endpoints/endpoints.dart';

class BookingRemoteDataSourceImpl extends BookingRemoteDataSource {
  @override
  Future<Result<AddOrderModel>> addOrder(int specialistId, int stableId,
      int stableServiceId, String paymentMethod, String bookingDate) async {
    return await RemoteDataSource.request<AddOrderModel>(
      converter: (model) => AddOrderModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "specialist_id": specialistId,
        "stable_id": stableId.toString(),
        "stable_service_id": stableServiceId.toString(),
        "payment_method": paymentMethod,
        "booking_date": bookingDate
      },
      url: AppEndpoints.baseUrl + AppEndpoints.addOrder,
    );
  }


  @override
  Future<Result<BookingAvailableTimes>> bookingAvailableTimes(String data, int stableId,
      int specialistId,int serviceId) async {
    return await RemoteDataSource.request<BookingAvailableTimes>(
      converter: (model) => BookingAvailableTimes.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Authorization':'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "date": data,
        "stable_id": stableId,
        "service_id": serviceId,
        "specialist_id": specialistId
      },
      url: AppEndpoints.baseUrl + AppEndpoints.bookingAvailableTime,
    );
  }

  @override
  Future<Result<BookingPackagesModel>> bookingPackages({required int packageId,
   required int stableId,required int bookingId}) async {
    return await RemoteDataSource.request<BookingPackagesModel>(
      converter: (model) => BookingPackagesModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Authorization':'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "package_id": packageId,
        "stable_id": stableId,
        "booking_id": bookingId,

      },
      url: AppEndpoints.baseUrl + AppEndpoints.bookingAvailableTime,
    );
  }


  @override
  Future<Result<BookingUserInStableModel>> bookingUserInStable({
    required int stableId,}) async {
    return await RemoteDataSource.request<BookingUserInStableModel>(
      converter: (model) => BookingUserInStableModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Authorization':'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "stable_id": stableId,
      },
      url: AppEndpoints.baseUrl + AppEndpoints.bookingUserInStable,
    );
  }

  @override
  Future<Result<BookingWithPackageModel>> getAllBookingWithPackages() async {
    return await RemoteDataSource.request<BookingWithPackageModel>(
      converter: (model) => BookingWithPackageModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {
        'Authorization':'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },

      url: AppEndpoints.baseUrl + AppEndpoints.bookingUserInStable,
    );
  }
}

abstract class BookingRemoteDataSource {
  const BookingRemoteDataSource();
  Future<Result<AddOrderModel>> addOrder(int specialistId, int stableId,
      int stableServiceId, String paymentMethod, String bookingDate);


    Future<Result<BookingAvailableTimes>> bookingAvailableTimes(String data, int stableId,
      int specialistId,int serviceId);

  Future<Result<BookingPackagesModel>> bookingPackages({required int packageId,
    required int stableId,required int bookingId});

  Future<Result<BookingUserInStableModel>> bookingUserInStable({
    required int stableId});

  Future<Result<BookingWithPackageModel>> getAllBookingWithPackages();
}
