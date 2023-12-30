import 'package:sevin_rm/Core/data_source/base_remote_data_source.dart';

import '../../../Core/di/di_manager.dart';
import '../../../Core/shared_prefs/shared_prefs.dart';
import '../../../core/net/http_method.dart';
import '../../../core/results/result.dart';
import '../../models/trainers/show_trainer.dart';
import '../../models/trainers/trainers_model.dart';
import '../endpoints/endpoints.dart';

abstract class TrainerRemoteDataSource {
  //
  Future<Result> trainer();
  Future<Result<ShowTrainerModel>> showTrainer({required int trainerId});
}

class TrainerRemoteDataImpl extends TrainerRemoteDataSource {
  @override
  Future<Result> trainer() async {
    return await RemoteDataSource.request<TrainersModel>(
      converter: (model) => TrainersModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      url: "${AppEndpoints.baseUrl}${AppEndpoints.trainers}",
    );
  }

  @override
  Future<Result<ShowTrainerModel>> showTrainer({required int trainerId}) async {
    return await RemoteDataSource.request<ShowTrainerModel>(
      converter: (model) => ShowTrainerModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${DIManager.findDep<SharedPrefs>().getToken()}'
      },
      data: {
        "traner_id":trainerId
      },
      url: "${AppEndpoints.baseUrl}${AppEndpoints.showTrainers}",
    );
  }
}
