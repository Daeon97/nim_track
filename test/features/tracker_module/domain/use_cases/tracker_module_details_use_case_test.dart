import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nim_track/features/tracker_module/domain/repositories/tracker_module_repository.dart';
import 'package:nim_track/features/tracker_module/domain/use_cases/tracker_module_details_use_case.dart';

import 'tracker_module_details_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TrackerModuleRepository>(),
])
void main() {
  late final MockTrackerModuleRepository mockTrackerModuleRepository;
  late final TrackerModuleDetailsUseCase trackerModuleDetailsUseCase;

  setUpAll(
    () {
      mockTrackerModuleRepository = MockTrackerModuleRepository();
      trackerModuleDetailsUseCase = TrackerModuleDetailsUseCase(
        trackerModuleRepository: mockTrackerModuleRepository,
      );
    },
  );

  test(
    '''
      should ensure that [MockTrackerModuleRepository.call]
      is called once when [TrackerModuleDetailsUseCase.call]
    ''',
    () {
      trackerModuleDetailsUseCase();

      verify(mockTrackerModuleRepository()).called(1);
      verifyNoMoreInteractions(mockTrackerModuleRepository);
    },
  );
}
