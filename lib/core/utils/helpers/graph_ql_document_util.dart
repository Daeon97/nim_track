// ignore_for_file: public_member_api_docs

import 'package:nim_track/core/utils/enums.dart' as enums;

final class GraphQLDocumentUtil {
  static String getTrackerModuleQueryDocument({
    required int id,
    List<enums.Field>? fields,
  }) =>
      '''
        query GetTrackerModuleQuery {
          getTrackerModule(id: $id) {
            id
            ${fields == null || fields.contains(enums.Field.name) ? 'name' : ''}
            ${fields == null || fields.contains(enums.Field.hash) || fields.contains(enums.Field.latLng) || fields.contains(enums.Field.batteryLevel) || fields.contains(enums.Field.timestamp) ? 'data {' : ''}
            ${fields == null || fields.contains(enums.Field.hash) || fields.contains(enums.Field.latLng) ? '  coordinates {' : ''}
            ${fields == null || fields.contains(enums.Field.hash) ? '    hash' : ''}
            ${fields == null || fields.contains(enums.Field.latLng) ? '    lat_lng' : ''}
            ${fields == null || fields.contains(enums.Field.hash) || fields.contains(enums.Field.latLng) ? '  }' : ''}
            ${fields == null || fields.contains(enums.Field.batteryLevel) ? '  battery_level' : ''}
            ${fields == null || fields.contains(enums.Field.timestamp) ? '  timestamp' : ''}
            ${fields == null || fields.contains(enums.Field.hash) || fields.contains(enums.Field.latLng) || fields.contains(enums.Field.batteryLevel) || fields.contains(enums.Field.timestamp) ? '}' : ''}
          }
        }
      ''';

  static String listTrackerModulesQueryDocument({
    List<enums.Field>? fields,
  }) =>
      '''
        query ListTrackerModulesQuery {
          listTrackerModules {
            id
            ${fields == null || fields.contains(enums.Field.name) ? 'name' : ''}
            ${fields == null || fields.contains(enums.Field.hash) || fields.contains(enums.Field.latLng) || fields.contains(enums.Field.batteryLevel) || fields.contains(enums.Field.timestamp) ? 'data {' : ''}
            ${fields == null || fields.contains(enums.Field.hash) || fields.contains(enums.Field.latLng) ? '  coordinates {' : ''}
            ${fields == null || fields.contains(enums.Field.hash) ? '    hash' : ''}
            ${fields == null || fields.contains(enums.Field.latLng) ? '    lat_lng' : ''}
            ${fields == null || fields.contains(enums.Field.hash) || fields.contains(enums.Field.latLng) ? '  }' : ''}
            ${fields == null || fields.contains(enums.Field.batteryLevel) ? '  battery_level' : ''}
            ${fields == null || fields.contains(enums.Field.timestamp) ? '  timestamp' : ''}
            ${fields == null || fields.contains(enums.Field.hash) || fields.contains(enums.Field.latLng) || fields.contains(enums.Field.batteryLevel) || fields.contains(enums.Field.timestamp) ? '}' : ''}
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
