import 'package:sevin_rm/core/net/http_method.dart';

import '../../../../core/results/result.dart';
import '../../../Core/data_source/base_remote_data_source.dart';
import '../../models/categories/categories_model.dart';
import '../../models/categories/stables_services_package_model.dart';
import '../endpoints/endpoints.dart';

class CategoriesRemoteDataSourceImpl extends CategoriesRemoteDataSource {
  @override
  Future<Result<CategoriesModel>> getAllCategories() async {
    return await RemoteDataSource.request<CategoriesModel>(
      converter: (model) => CategoriesModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: false},
      url: AppEndpoints.baseUrl + AppEndpoints.category,
    );
  }

  @override
  Future<Result<StablesPackagesServicesCategoryModel>> getIncludeCategory({required int categoryId }) async {
    return await RemoteDataSource.request<StablesPackagesServicesCategoryModel>(
      converter: (model) => StablesPackagesServicesCategoryModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: false},
      data: {
      "category_id":categoryId
      },
      url: AppEndpoints.baseUrl + AppEndpoints.servicesStablePackages,
    );
  }
}

abstract class CategoriesRemoteDataSource {
  const CategoriesRemoteDataSource();

  Future<Result<CategoriesModel>> getAllCategories();
  Future<Result<StablesPackagesServicesCategoryModel>> getIncludeCategory({required int categoryId });
}
