import '../../../../core/models/base_entity.dart';

import '../../../../data/models/version/entity/mock_version_entity.dart';
import '../../../Core/models/base_models.dart';

class MockVersionModel extends BaseModel {
  String? newestVersion;
  String? minimumSupportedVersion;
  String? updateUrl;

  MockVersionModel(
      {this.newestVersion, this.minimumSupportedVersion, this.updateUrl});

  @override
  BaseEntity toEntity() {
    return MockVersionEntity(
      latestVersion: newestVersion,
      minimumSupportedVersion: minimumSupportedVersion,
      updateUrl: updateUrl,
    );
  }
}
