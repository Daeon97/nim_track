// ignore_for_file: public_member_api_docs

final class GraphQLDocumentUtil {
  static String getTrackerModuleQueryDocument({
    required int id,
  }) =>
      '''
        query GetTrackerModuleQuery {
          getTrackerModule(id: $id) {
            id
            name
            data {
              coordinates {
                hash
                lat_lng
              }
              battery_level
              timestamp
            }
          }
        }
      ''';

  static String listTrackerModulesQueryDocument() => '''
        query ListTrackerModulesQuery {
          listTrackerModules {
            id
            name
            data {
              coordinates {
                hash
                lat_lng
              }
              battery_level
              timestamp
            }
          }
        }
      ''';

  static String updateTrackerModuleNameMutationDocument({
    required int id,
    required String name,
  }) =>
      '''
        mutation UpdateTrackerModuleNameMutation {
          updateTrackerModuleName(input: {id: $id, name: "$name"})
        }
      ''';
}
