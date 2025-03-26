// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flowery_app/core/logger/logger_module.dart' as _i495;
import 'package:flowery_app/core/network/remote/api_manager.dart' as _i797;
import 'package:flowery_app/core/network/remote/dio_module.dart' as _i338;
import 'package:flowery_app/features/auth/api/data_source_impl/auth_data_source_impl.dart'
    as _i447;
import 'package:flowery_app/features/auth/api/webServices/auth_retrofit_client.dart'
    as _i742;
import 'package:flowery_app/features/auth/data/data_source/auth_data_source.dart'
    as _i392;
import 'package:flowery_app/features/auth/data/repository_imp/auth_repository_impl.dart'
    as _i82;
import 'package:flowery_app/features/auth/domain/repository/auth_repository.dart'
    as _i426;
import 'package:flowery_app/features/auth/domain/usecase/login_use_case.dart'
    as _i541;
import 'package:flowery_app/features/auth/presentation/presentation_login/view_model/login_cubit.dart'
    as _i488;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final loggerModule = _$LoggerModule();
    final dioModule = _$DioModule();
    gh.singleton<_i797.ApiManager>(() => _i797.ApiManager());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.lazySingleton<_i528.PrettyDioLogger>(
        () => dioModule.providerInterceptor());
    gh.lazySingleton<_i742.ApiClient>(() => _i742.ApiClient());
    gh.lazySingleton<_i742.AuthRetrofitClient>(
        () => _i742.AuthRetrofitClient(gh<_i361.Dio>()));
    gh.factory<_i392.LoginDataSource>(
        () => _i447.LoginDataSourceImpl(gh<_i742.ApiClient>()));
    gh.factory<_i426.LoginRepository>(
        () => _i82.LoginRepositoryImpl(gh<_i392.LoginDataSource>()));
    gh.factory<_i541.LoginUseCase>(
        () => _i541.LoginUseCase(gh<_i426.LoginRepository>()));
    gh.factory<_i488.LoginCubit>(
        () => _i488.LoginCubit(gh<_i541.LoginUseCase>()));
    return this;
  }
}

class _$LoggerModule extends _i495.LoggerModule {}

class _$DioModule extends _i338.DioModule {}
