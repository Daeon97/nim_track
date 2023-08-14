import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/tracker_module/domain/repositories/tracker_module_repository.dart';
import 'package:nim_track/features/tracker_module/domain/use_cases/tracker_module_use_case.dart';

import 'tracker_module_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TrackerModuleRepository>(),
])
void main() {
  late final MockTrackerModuleRepository mockTrackerModuleRepository;
  late final TrackerModuleUseCase trackerModuleUseCase;
  late final int testId;
  late final String testName;
  late final List<enums.Field> testFields;

  setUpAll(
    () {
      mockTrackerModuleRepository = MockTrackerModuleRepository();
      trackerModuleUseCase = TrackerModuleUseCase(
        trackerModuleRepository: mockTrackerModuleRepository,
      );
      testId = 5;
      testName = 'Test';
      testFields = [
        enums.Field.name,
        enums.Field.batteryLevel,
        enums.Field.hash,
      ];
    },
  );

  group(
    'getTrackerModule',
    () {
      test(
        '''
      should ensure that [TrackerModuleRepository.getTrackerModule]
      is called with the same fields once when
      [TrackerModuleUseCase.getTrackerModule] is invoked with fields
    ''',
        () {
          trackerModuleUseCase.getTrackerModule(
            id: testId,
            fields: testFields,
          );

          verify(
            mockTrackerModuleRepository.getTrackerModule(
              id: testId,
              fields: testFields,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockTrackerModuleRepository);
        },
      );

      test(
        '''
      should ensure that [TrackerModuleRepository.getTrackerModule]
      is called with no fields once when
      [TrackerModuleUseCase.getTrackerModule] is invoked with no fields
    ''',
        () {
          trackerModuleUseCase.getTrackerModule(
            id: testId,
          );

          verify(
            mockTrackerModuleRepository.getTrackerModule(
              id: testId,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockTrackerModuleRepository);
        },
      );
    },
  );

  group(
    'listTrackerModules',
    () {
      test(
        '''
      should ensure that [TrackerModuleRepository.listTrackerModules]
      is called with the same fields once when
      [TrackerModuleUseCase.listTrackerModules] is invoked with fields
    ''',
        () {
          trackerModuleUseCase.listTrackerModules(
            fields: testFields,
          );

          verify(
            mockTrackerModuleRepository.listTrackerModules(
              fields: testFields,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockTrackerModuleRepository);
        },
      );

      test(
        '''
      should ensure that [TrackerModuleRepository.listTrackerModules]
      is called with no fields once when
      [TrackerModuleUseCase.listTrackerModules] is invoked with no fields
    ''',
        () {
          trackerModuleUseCase.listTrackerModules();

          verify(
            mockTrackerModuleRepository.listTrackerModules(),
          ).called(1);
          verifyNoMoreInteractions(mockTrackerModuleRepository);
        },
      );
    },
  );

  test(
    '''
      should ensure that [TrackerModuleRepository.updateTrackerModuleName]
      is called when
      [TrackerModuleUseCase.updateTrackerModuleName] is invoked
    ''',
    () {
      trackerModuleUseCase.updateTrackerModuleName(
        id: testId,
        name: testName,
      );

      verify(
        mockTrackerModuleRepository.updateTrackerModuleName(
          id: testId,
          name: testName,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockTrackerModuleRepository);
    },
  );
}
