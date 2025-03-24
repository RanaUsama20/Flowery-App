// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flowery_app/core/app/app_cubit/app_cubit_cubit.dart' as _i575;
import 'package:flowery_app/core/logger/logger_module.dart' as _i495;
import 'package:flowery_app/core/network/remote/api_manager.dart' as _i797;
import 'package:flowery_app/core/network/remote/dio_module.dart' as _i338;
import 'package:flowery_app/features/auth/api/auth_retrofit_client.dart'
    as _i955;
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
    gh.factory<_i575.AppCubit>(() => _i575.AppCubit());
    gh.singleton<_i797.ApiManager>(() => _i797.ApiManager());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.lazySingleton<_i528.PrettyDioLogger>(
        () => dioModule.providerInterceptor());
    gh.lazySingleton<_i955.AuthRetrofitClient>(
        () => _i955.AuthRetrofitClient(gh<_i361.Dio>()));
    return this;
  }
}

class _$LoggerModule extends _i495.LoggerModule {}

class _$DioModule extends _i338.DioModule {}
