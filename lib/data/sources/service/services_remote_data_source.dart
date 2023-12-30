


import 'package:sevin_rm/Core/data_source/base_remote_data_source.dart';
import 'package:sevin_rm/data/models/services/servicesModel.dart';

import '../../../core/net/http_method.dart';
import '../../../core/results/result.dart';
import '../endpoints/endpoints.dart';

class ServicesData extends ServicesDataSource{
  @override
  Future<Result> getServices(int id) async {
    return await RemoteDataSource.request<ServicesModel>(
      converter: (model) => ServicesModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      data: null,
      url: "${AppEndpoints.baseUrl}${AppEndpoints.servicesUrl}/$id",
    );
  }
}


abstract class ServicesDataSource{
  const ServicesDataSource();


  Future<Result>getServices(int id);
}

