// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:nim_track/features/tracker_module/data/models/tracker_module_model.dart';

abstract interface class TrackerModuleRemoteDataSource {
  Stream<TrackerModuleModel> call();
}

class TrackerModuleRemoteDataSourceImplementation
    implements TrackerModuleRemoteDataSource {
  @override
  Stream<TrackerModuleModel> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
