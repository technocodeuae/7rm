import 'package:sevin_rm/Core/data_source/base_remote_data_source.dart';
import 'package:sevin_rm/core/results/result.dart';
import 'package:sevin_rm/data/models/auctions/all_auctions_today.dart';
import 'package:sevin_rm/data/sources/endpoints/endpoints.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../core/net/http_method.dart';
import '../../models/auctions/all_auctions.dart';
import '../../models/auctions/all_my_auctions.dart';
import '../../models/auctions/auction_calendar_model.dart';

abstract class AuctionsRemoteDataSource {
  // Future<Result> getCalendarAuctions();

  Future<Result> getAllAuctions(bool isSortedByPrice);
}

class AuctionsRemoteDataImpl extends AuctionsRemoteDataSource {
  @override
  Future<Result> getAllAuctions(bool isSortedByPrice) async {
    return await RemoteDataSource.request<AllAuctions>(
      converter: (model) => AllAuctions.fromJson(model),
      method: HttpMethod.GET,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: null,
      url:
      "${AppEndpoints.baseUrl}${isSortedByPrice ? AppEndpoints
          .allAuctionsByPrice : AppEndpoints.allAuctionsRandomly}",
    );
  }
  Future<Result> getAllAuctionsToday() async {
    return await RemoteDataSource.request<AuctionsToday>(
      converter: (model) => AuctionsToday.fromJson(model),
      method: HttpMethod.GET,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: null,
      url:
      "${AppEndpoints.baseUrl}${AppEndpoints.auctionToday}",
    );
  }

  Future<Result> getAllMyAuctions() async {
    return await RemoteDataSource.request<MyAuctions>(
      converter: (model) => MyAuctions.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: null,
      url:
      "${AppEndpoints.baseUrl}${AppEndpoints.myAuctions}",
    );
  }

  Future<Result> getCalendarAuctions() async {
    return await RemoteDataSource.request<AuctionCalendarModel>(
      converter: (model) => AuctionCalendarModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: null,
      url: "${AppEndpoints.baseUrl}${AppEndpoints.auctionsCalendar}",
    );
  }

  Future<Result> checkIfPayment(int horseId) async {
    return await RemoteDataSource.request<bool>(
      converter: (model) => model['is_payed_?'],
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "horse_id": horseId
      },
      url: "${AppEndpoints.baseUrl}${AppEndpoints.checkedPayment}",
    );
  }

  Future<Result> acceptPayment(int horseId) async {
    return await RemoteDataSource.request<bool>(
      converter: (model) => model['payed?'],
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "horse_id": horseId,
        "accept":true
      },
      url: "${AppEndpoints.baseUrl}${AppEndpoints.pay}",
    );
  }

  Future<Result> sendPusher(int auctionId , int horseId , double auctionValue) async {
    return await RemoteDataSource.request<bool>(
      converter: (model) => model['value'],
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "auction_id": auctionId,
        "horse_id":horseId,
        "value":auctionValue
      },
      url: "${AppEndpoints.baseUrl}${AppEndpoints.sendPusher}",
    );
  }
}
