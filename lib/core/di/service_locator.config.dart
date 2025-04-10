// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flowery_app/core/app/app_cubit/app_cubit_cubit.dart' as _i826;
import 'package:flowery_app/core/logger/logger_module.dart' as _i495;
import 'package:flowery_app/core/network/remote/api_manager.dart' as _i797;
import 'package:flowery_app/core/network/remote/dio_module.dart' as _i338;
import 'package:flowery_app/features/auth/data/api/auth_retrofit_client.dart'
    as _i865;
import 'package:flowery_app/features/auth/data/data_source/auth_data_source.dart'
    as _i392;
import 'package:flowery_app/features/auth/data/data_source/auth_data_source_impl.dart'
    as _i136;
import 'package:flowery_app/features/auth/data/data_source/remote/register_remote_data_source.dart'
    as _i1041;
import 'package:flowery_app/features/auth/data/data_source/remote/register_remote_data_source_impl.dart'
    as _i470;
import 'package:flowery_app/features/auth/data/repository_imp/auth_repository_impl.dart'
    as _i82;
import 'package:flowery_app/features/auth/domain/repository/auth_repository.dart'
    as _i426;
import 'package:flowery_app/features/auth/domain/usecase/auth_use_case.dart'
    as _i255;
import 'package:flowery_app/features/auth/domain/usecase/login_use_case.dart'
    as _i541;
import 'package:flowery_app/features/auth/domain/usecase/register_use_case.dart'
    as _i318;
import 'package:flowery_app/features/auth/presentation/view_model/cubit/forgot_password_cubit.dart'
    as _i520;
import 'package:flowery_app/features/auth/presentation/view_model/cubit/login_cubit.dart'
    as _i609;
import 'package:flowery_app/features/auth/presentation/view_model/cubit/register_cubit.dart'
    as _i475;
import 'package:flowery_app/features/categories/data/api/getl_categories_retrofit_client.dart'
    as _i557;
import 'package:flowery_app/features/categories/data/data_source/getCategories_data_source.dart'
    as _i129;
import 'package:flowery_app/features/categories/data/data_source/getCategories_data_source_impl.dart'
    as _i48;
import 'package:flowery_app/features/categories/data/repository_imp/getCategories_repository_impl.dart'
    as _i578;
import 'package:flowery_app/features/categories/domain/repository/getCategories_repository.dart'
    as _i427;
import 'package:flowery_app/features/categories/domain/usecase/getCategories_use_case.dart'
    as _i494;
import 'package:flowery_app/features/categories/presentation/view_model/cubit/categories_cubit.dart'
    as _i57;
import 'package:flowery_app/features/home/data/data_source/home_data_source.dart'
    as _i787;
import 'package:flowery_app/features/home/data/data_source/home_data_source_impl.dart'
    as _i449;
import 'package:flowery_app/features/home/data/repository_imp/auth_repository_impl.dart'
    as _i888;
import 'package:flowery_app/features/home/domain/repository/home_repository.dart'
    as _i630;
import 'package:flowery_app/features/home/domain/usecase/home_use_case.dart'
    as _i683;
import 'package:flowery_app/features/home/presentation/view_model/cubit/home_cubit.dart'
    as _i373;
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
    gh.factory<_i826.AppCubit>(() => _i826.AppCubit());
    gh.factory<_i683.HomeUseCase>(() => _i683.HomeUseCase());
    gh.factory<_i373.HomeCubit>(() => _i373.HomeCubit());
    gh.singleton<_i797.ApiManager>(() => _i797.ApiManager());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.lazySingleton<_i528.PrettyDioLogger>(
        () => dioModule.providerInterceptor());
    gh.lazySingleton<_i865.AuthRetrofitClient>(
        () => _i865.AuthRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i557.CategoriesRetrofitClient>(
        () => _i557.CategoriesRetrofitClient(gh<_i361.Dio>()));
    gh.factory<_i1041.RegisterRemoteDataSource>(
        () => _i470.RegisterDataSourceImpl(gh<_i865.AuthRetrofitClient>()));
    gh.factory<_i787.HomeDataSource>(() => _i449.HomeDataSourceImpl());
    gh.factory<_i630.HomeRepository>(() => _i888.HomeRepositoryImpl());
    gh.factory<_i129.GetAllCategoriesDataSource>(() =>
        _i48.GetAllCategoriesDataSourceImpl(
            gh<_i557.CategoriesRetrofitClient>()));
    gh.factory<_i392.AuthDataSource>(() => _i136.AuthDataSourceImpl(
          gh<_i865.AuthRetrofitClient>(),
          gh<_i797.ApiManager>(),
          gh<_i865.AuthRetrofitClient>(),
        ));
    gh.factory<_i129.GetProductsByIdDataSource>(() =>
        _i48.GetProductsByIdDataSourceImpl(
            gh<_i557.CategoriesRetrofitClient>()));
    gh.factory<_i427.GetCategoriesRepository>(() =>
        _i578.GetCategoriesRepositoryImpl(
            gh<_i129.GetAllCategoriesDataSource>()));
    gh.factory<_i426.AuthRepository>(() => _i82.AuthRepositoryImpl(
          gh<_i1041.RegisterRemoteDataSource>(),
          gh<_i797.ApiManager>(),
          gh<_i392.AuthDataSource>(),
        ));
    gh.factory<_i541.LoginUseCase>(
        () => _i541.LoginUseCase(gh<_i426.AuthRepository>()));
    gh.factory<_i609.LoginCubit>(
        () => _i609.LoginCubit(gh<_i541.LoginUseCase>()));
    gh.factory<_i318.RegisterUseCase>(
        () => _i318.RegisterUseCase(gh<_i426.AuthRepository>()));
    gh.factory<_i427.GetProductsByIdRepository>(() =>
        _i578.GetProductsByIdRepositoryImpl(
            gh<_i129.GetProductsByIdDataSource>()));
    gh.factory<_i255.AuthUseCase>(
        () => _i255.AuthUseCase(gh<_i426.AuthRepository>()));
    gh.factory<_i475.RegisterCubit>(
        () => _i475.RegisterCubit(gh<_i318.RegisterUseCase>()));
    gh.factory<_i494.GetCategoriesUseCase>(() => _i494.GetCategoriesUseCase(
          gh<_i427.GetCategoriesRepository>(),
          gh<_i427.GetProductsByIdRepository>(),
        ));
    gh.factory<_i520.ForgotPasswordCubit>(
        () => _i520.ForgotPasswordCubit(gh<_i255.AuthUseCase>()));
    gh.factory<_i57.CategoriesCubit>(
        () => _i57.CategoriesCubit(gh<_i494.GetCategoriesUseCase>()));
    return this;
  }
}

class _$LoggerModule extends _i495.LoggerModule {}

class _$DioModule extends _i338.DioModule {}
