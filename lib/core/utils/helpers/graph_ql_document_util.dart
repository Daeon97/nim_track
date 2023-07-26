// ignore_for_file: public_member_api_docs

final class GraphQLDocumentUtil {
  static String updateTrackerModuleNameMutationDocument({
    required int id,
    required String name,
  }) =>
      '''
        mutation MyMutation {
          updateTrackerModuleName(input: {id: $id, name: $name})
        }
      ''';

  static String onGetTrackerModuleSubscriptionDocument({
    required int id,
  }) =>
      '''
        subscription MySubscription {
          onGetTrackerModule(id: $id) {
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

  static String onListTrackerModulesSubscriptionDocument() => '''
        subscription MySubscription {
          onListTrackerModules {
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
}
