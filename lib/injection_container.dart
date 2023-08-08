// ignore_for_file: public_member_api_docs

import 'package:get_it/get_it.dart';
import 'package:nim_track/features/settings/data/data_sources/theme_data_source.dart';
import 'package:nim_track/features/settings/data/repositories/theme_repository_implementation.dart';
import 'package:nim_track/features/settings/domain/repositories/theme_repository.dart';
import 'package:nim_track/features/settings/domain/use_cases/theme_use_case.dart';
import 'package:nim_track/features/settings/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:nim_track/features/tracker_module/data/data_sources/tracker_module_remote_data_source.dart';
import 'package:nim_track/features/tracker_module/data/repositories/tracker_module_repository_implementation.dart';
import 'package:nim_track/features/tracker_module/domain/repositories/tracker_module_repository.dart';
import 'package:nim_track/features/tracker_module/domain/use_cases/tracker_module_use_case.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/all_tracker_modules_or_one_tracker_module/all_tracker_modules_or_one_tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_bloc/tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_detail_bloc/tracker_module_detail_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_detail_bloc/tracker_modules_detail_bloc.dart';

final sl = GetIt.I;

void initDependencyInjection() {
  sl
    // Blocs
    ..registerFactory(
      () => ThemeBloc(
        themeUseCase: sl(),
      ),
    )
    ..registerFactory(
      () => TrackerModuleBloc(
        trackerModuleUseCase: sl(),
      ),
    )
    ..registerFactory(
      () => TrackerModulesBloc(
        trackerModuleUseCase: sl(),
      ),
    )
    ..registerFactory(
      AllTrackerModulesOrOneTrackerModuleBloc.new,
    )
    ..registerFactory(
      () => TrackerModuleDetailBloc(
        trackerModuleUseCase: sl(),
      ),
    )
    ..registerFactory(
      () => TrackerModulesDetailBloc(
        trackerModuleUseCase: sl(),
      ),
    )

    // Use cases
    ..registerLazySingleton(
      () => TrackerModuleUseCase(
        trackerModuleRepository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => ThemeUseCase(
        themeRepository: sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<TrackerModuleRepository>(
      () => TrackerModuleRepositoryImplementation(
        trackerModuleRemoteDataSource: sl(),
      ),
    )
    ..registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImplementation(
        themeDataSource: sl(),
      ),
    )

    // Data sources
    ..registerLazySingleton<TrackerModuleRemoteDataSource>(
      TrackerModuleRemoteDataSourceImplementation.new,
    )
    ..registerLazySingleton<ThemeDataSource>(
      ThemeDataSourceImplementation.new,
    );
}
