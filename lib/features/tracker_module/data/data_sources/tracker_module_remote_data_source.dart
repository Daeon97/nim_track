// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/clients/graph_ql_operation_handler.dart';
import 'package:nim_track/core/utils/helpers/graph_ql_document_util.dart';
import 'package:nim_track/features/tracker_module/data/models/tracker_module_model.dart';

abstract interface class TrackerModuleRemoteDataSource {
  Future<TrackerModuleModel> getTrackerModule({
    required int id,
  });

  Future<List<TrackerModuleModel>> listTrackerModules();

  Future<String> updateTrackerModuleName({
    required int id,
    required String name,
  });
}

class TrackerModuleRemoteDataSourceImplementation
    with GraphQLOperationHandler
    implements TrackerModuleRemoteDataSource {
  @override
  Future<TrackerModuleModel> getTrackerModule({
    required int id,
  }) =>
      call<TrackerModuleModel, Map<String, dynamic>>(
        graphQLDocument: GraphQLDocumentUtil.getTrackerModuleQueryDocument(
          id: id,
        ),
        actualDataResidenceKey: getTrackerModuleKey,
        handler: TrackerModuleModel.fromJson,
      );

  @override
  Future<List<TrackerModuleModel>> listTrackerModules() =>
      call<List<TrackerModuleModel>, List<dynamic>>(
        graphQLDocument: GraphQLDocumentUtil.listTrackerModulesQueryDocument(),
        actualDataResidenceKey: listTrackerModulesKey,
        handler: (
          jsonList,
        ) =>
            jsonList
                .map(
                  (json) => TrackerModuleModel.fromJson(
                    json as Map<String, dynamic>,
                  ),
                )
                .toList(),
      );

  @override
  Future<String> updateTrackerModuleName({
    required int id,
    required String name,
  }) =>
      call<String, String>(
        graphQLDocument:
            GraphQLDocumentUtil.updateTrackerModuleNameMutationDocument(
          id: id,
          name: name,
        ),
        actualDataResidenceKey: updateTrackerModuleNameKey,
        handler: (
          string,
        ) =>
            string,
      );
}
