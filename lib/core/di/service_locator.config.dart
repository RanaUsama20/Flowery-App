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
import 'package:flowery_app/features/auth/data/api/upload_photo_api_service.dart'
    as _i127;
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
import 'package:flowery_app/features/auth/domain/usecase/edit_profile_use_case.dart'
    as _i205;
import 'package:flowery_app/features/auth/domain/usecase/forgot_password_use_case.dart'
    as _i371;
import 'package:flowery_app/features/auth/domain/usecase/login_use_case.dart'
    as _i541;
import 'package:flowery_app/features/auth/domain/usecase/logout_use_case.dart'
    as _i226;
import 'package:flowery_app/features/auth/domain/usecase/register_use_case.dart'
    as _i318;
import 'package:flowery_app/features/auth/domain/usecase/reset_password_use_case.dart'
    as _i967;
import 'package:flowery_app/features/auth/domain/usecase/upload_photo_use_case.dart'
    as _i728;
import 'package:flowery_app/features/auth/domain/usecase/verify_reset_code_use_case.dart'
    as _i603;
import 'package:flowery_app/features/auth/presentation/view_model/cubit/edit_profile_cubit.dart'
    as _i170;
import 'package:flowery_app/features/auth/presentation/view_model/forgot_password/forgot_password_cubit.dart'
    as _i680;
import 'package:flowery_app/features/auth/presentation/view_model/login/login_cubit.dart'
    as _i45;
import 'package:flowery_app/features/auth/presentation/view_model/register/register_cubit.dart'
    as _i555;
import 'package:flowery_app/features/cart/data/api/cart_retrofit_client.dart'
    as _i881;
import 'package:flowery_app/features/cart/data/data_source/cart_data_source.dart'
    as _i301;
import 'package:flowery_app/features/cart/data/data_source/cart_data_source_impl.dart'
    as _i895;
import 'package:flowery_app/features/cart/data/repository_impl/cart_repository_impl.dart'
    as _i221;
import 'package:flowery_app/features/cart/domain/repository/cart_repository.dart'
    as _i166;
import 'package:flowery_app/features/cart/domain/usecase/cart_usecase.dart'
    as _i485;
import 'package:flowery_app/features/cart/presentation/view_model/cart_cubit.dart'
    as _i645;
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
import 'package:flowery_app/features/checkout/data/api/checkout_retrofit_client.dart'
    as _i560;
import 'package:flowery_app/features/checkout/data/data_source/remote/checkout_remote_data_source.dart'
    as _i711;
import 'package:flowery_app/features/checkout/data/data_source/remote/checkout_remote_data_source_impl.dart'
    as _i16;
import 'package:flowery_app/features/checkout/data/repository_imp/checkout_repository_impl.dart'
    as _i876;
import 'package:flowery_app/features/checkout/domain/repository/checkout_repository.dart'
    as _i533;
import 'package:flowery_app/features/checkout/domain/usecase/best_seller_use_case.dart'
    as _i419;
import 'package:flowery_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart'
    as _i643;
import 'package:flowery_app/features/home/data/api/home_retrofit_client.dart'
    as _i1039;
import 'package:flowery_app/features/home/data/data_source/remote/home_remote_data_source.dart'
    as _i3;
import 'package:flowery_app/features/home/data/data_source/remote/home_remote_data_source_impl.dart'
    as _i550;
import 'package:flowery_app/features/home/data/repository_imp/home_repository_impl.dart'
    as _i271;
import 'package:flowery_app/features/home/domain/repository/home_repository.dart'
    as _i630;
import 'package:flowery_app/features/home/domain/usecase/best_seller_use_case.dart'
    as _i675;
import 'package:flowery_app/features/home/domain/usecase/home_use_case.dart'
    as _i683;
import 'package:flowery_app/features/home/domain/usecase/occasions_use_case.dart'
    as _i7;
import 'package:flowery_app/features/home/domain/usecase/product_occasion_use_case.dart'
    as _i997;
import 'package:flowery_app/features/home/presentation/view_model/cubit/best_seller/best_seller_cubit.dart'
    as _i255;
import 'package:flowery_app/features/home/presentation/view_model/cubit/home_cubit.dart'
    as _i373;
import 'package:flowery_app/features/home/presentation/view_model/occasions/occasions_cubit.dart'
    as _i331;
import 'package:flowery_app/features/profile/data/api/profile_retrofit_client.dart'
    as _i106;
import 'package:flowery_app/features/profile/data/data_source/remote/profile_remote_data_source.dart'
    as _i342;
import 'package:flowery_app/features/profile/data/data_source/remote/profile_remote_data_source_impl.dart'
    as _i1023;
import 'package:flowery_app/features/profile/data/repository_impl/profile_repository_impl.dart'
    as _i110;
import 'package:flowery_app/features/profile/domain/repository/profile_repository.dart'
    as _i1025;
import 'package:flowery_app/features/profile/domain/usecase/change_password_usecase.dart'
    as _i583;
import 'package:flowery_app/features/profile/domain/usecase/get_profile_data_usecase.dart'
    as _i110;
import 'package:flowery_app/features/profile/presentation/view_model/change_password/change_password_cubit.dart'
    as _i517;
import 'package:flowery_app/features/profile/presentation/view_model/profile_main/profile_main_cubit.dart'
    as _i859;
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
    gh.singleton<_i826.AppCubit>(() => _i826.AppCubit());
    gh.singleton<_i797.ApiManager>(() => _i797.ApiManager());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.lazySingleton<_i528.PrettyDioLogger>(
        () => dioModule.providerInterceptor());
    gh.lazySingleton<_i865.AuthRetrofitClient>(
        () => _i865.AuthRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i881.CartRetrofitClient>(
        () => _i881.CartRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i557.CategoriesRetrofitClient>(
        () => _i557.CategoriesRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i1039.HomeRetrofitClient>(
        () => _i1039.HomeRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i106.ProfileRetrofitClient>(
        () => _i106.ProfileRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i560.CheckoutRetrofitClient>(
        () => _i560.CheckoutRetrofitClient(gh<_i361.Dio>()));
    gh.factory<_i1041.RegisterRemoteDataSource>(
        () => _i470.RegisterDataSourceImpl(gh<_i865.AuthRetrofitClient>()));
    gh.lazySingleton<_i127.UploadPhotoApiService>(
        () => _i127.UploadPhotoApiService(gh<_i361.Dio>()));
    gh.factory<_i711.CheckoutRemoteDataSource>(
        () => _i16.CheckoutRemoteDataSourceImpl(
              gh<_i560.CheckoutRetrofitClient>(),
              gh<_i797.ApiManager>(),
            ));
    gh.factory<_i129.GetAllCategoriesDataSource>(() =>
        _i48.GetAllCategoriesDataSourceImpl(
            gh<_i557.CategoriesRetrofitClient>()));
    gh.factory<_i3.HomeRemoteDataSource>(() => _i550.HomeRemoteDataSourceImpl(
          gh<_i1039.HomeRetrofitClient>(),
          gh<_i797.ApiManager>(),
        ));
    gh.factory<_i630.HomeRepository>(() => _i271.HomeRepositoryImpl(
          gh<_i797.ApiManager>(),
          gh<_i3.HomeRemoteDataSource>(),
        ));
    gh.factory<_i392.AuthDataSource>(() => _i136.AuthDataSourceImpl(
          gh<_i865.AuthRetrofitClient>(),
          gh<_i797.ApiManager>(),
          gh<_i865.AuthRetrofitClient>(),
          gh<_i127.UploadPhotoApiService>(),
          gh<_i106.ProfileRetrofitClient>(),
        ));
    gh.factory<_i342.ProfileRemoteDataSource>(
        () => _i1023.ProfileRemoteDataSourceImpl(
              gh<_i106.ProfileRetrofitClient>(),
              gh<_i797.ApiManager>(),
            ));
    gh.factory<_i1025.ProfileRepository>(
        () => _i110.ProfileRepositoryImpl(gh<_i342.ProfileRemoteDataSource>()));
    gh.factory<_i533.CheckoutRepository>(() => _i876.CheckoutRepositoryImpl(
          gh<_i797.ApiManager>(),
          gh<_i711.CheckoutRemoteDataSource>(),
        ));
    gh.factory<_i129.GetProductsByIdDataSource>(() =>
        _i48.GetProductsByIdDataSourceImpl(
            gh<_i557.CategoriesRetrofitClient>()));
    gh.factory<_i301.CartRemoteDataSource>(() => _i895.CartRemoteDataSourceImpl(
          gh<_i881.CartRetrofitClient>(),
          gh<_i797.ApiManager>(),
        ));
    gh.factory<_i427.GetCategoriesRepository>(() =>
        _i578.GetCategoriesRepositoryImpl(
            gh<_i129.GetAllCategoriesDataSource>()));
    gh.factory<_i426.AuthRepository>(() => _i82.AuthRepositoryImpl(
          gh<_i1041.RegisterRemoteDataSource>(),
          gh<_i797.ApiManager>(),
          gh<_i392.AuthDataSource>(),
        ));
    gh.factory<_i583.ChangePasswordUseCase>(
        () => _i583.ChangePasswordUseCase(gh<_i1025.ProfileRepository>()));
    gh.factory<_i7.OccasionsUseCase>(
        () => _i7.OccasionsUseCase(gh<_i630.HomeRepository>()));
    gh.factory<_i997.ProductOccasionUseCase>(
        () => _i997.ProductOccasionUseCase(gh<_i630.HomeRepository>()));
    gh.factory<_i541.LoginUseCase>(
        () => _i541.LoginUseCase(gh<_i426.AuthRepository>()));
    gh.factory<_i45.LoginCubit>(
        () => _i45.LoginCubit(gh<_i541.LoginUseCase>()));
    gh.factory<_i166.CartRepository>(
        () => _i221.CartRepositoryImpl(gh<_i301.CartRemoteDataSource>()));
    gh.factory<_i110.GetProfileDataUseCase>(
        () => _i110.GetProfileDataUseCase(gh<_i1025.ProfileRepository>()));
    gh.factory<_i675.BestSellerUseCase>(
        () => _i675.BestSellerUseCase(gh<_i630.HomeRepository>()));
    gh.factory<_i683.HomeUseCase>(
        () => _i683.HomeUseCase(gh<_i630.HomeRepository>()));
    gh.factory<_i485.CartUseCase>(
        () => _i485.CartUseCase(gh<_i166.CartRepository>()));
    gh.factory<_i645.CartCubit>(() => _i645.CartCubit(gh<_i485.CartUseCase>()));
    gh.factory<_i419.CheckoutUseCase>(
        () => _i419.CheckoutUseCase(gh<_i533.CheckoutRepository>()));
    gh.factory<_i643.CheckoutCubit>(
        () => _i643.CheckoutCubit(gh<_i419.CheckoutUseCase>()));
    gh.factory<_i371.ForgotPasswordUseCase>(
        () => _i371.ForgotPasswordUseCase(gh<_i426.AuthRepository>()));
    gh.factory<_i318.RegisterUseCase>(
        () => _i318.RegisterUseCase(gh<_i426.AuthRepository>()));
    gh.factory<_i967.ResetPasswordUseCase>(
        () => _i967.ResetPasswordUseCase(gh<_i426.AuthRepository>()));
    gh.factory<_i603.VerifyResetCodeUseCase>(
        () => _i603.VerifyResetCodeUseCase(gh<_i426.AuthRepository>()));
    gh.factory<_i226.LogoutUseCase>(
        () => _i226.LogoutUseCase(gh<_i426.AuthRepository>()));
    gh.factory<_i859.ProfileMainCubit>(() => _i859.ProfileMainCubit(
          gh<_i110.GetProfileDataUseCase>(),
          gh<_i226.LogoutUseCase>(),
          gh<_i826.AppCubit>(),
        ));
    gh.factory<_i427.GetProductsByIdRepository>(() =>
        _i578.GetProductsByIdRepositoryImpl(
            gh<_i129.GetProductsByIdDataSource>()));
    gh.factory<_i517.ChangePasswordCubit>(
        () => _i517.ChangePasswordCubit(gh<_i583.ChangePasswordUseCase>()));
    gh.factory<_i331.OccasionsCubit>(() => _i331.OccasionsCubit(
          gh<_i7.OccasionsUseCase>(),
          gh<_i997.ProductOccasionUseCase>(),
        ));
    gh.factory<_i205.EditProfileUseCase>(
        () => _i205.EditProfileUseCase(gh<_i426.AuthRepository>()));
    gh.factory<_i728.UploadPhotoUseCase>(
        () => _i728.UploadPhotoUseCase(gh<_i426.AuthRepository>()));
    gh.factory<_i255.BestSellerCubit>(
        () => _i255.BestSellerCubit(gh<_i675.BestSellerUseCase>()));
    gh.factory<_i373.HomeCubit>(() => _i373.HomeCubit(gh<_i683.HomeUseCase>()));
    gh.factory<_i555.RegisterCubit>(
        () => _i555.RegisterCubit(gh<_i318.RegisterUseCase>()));
    gh.factory<_i170.EditProfileCubit>(() => _i170.EditProfileCubit(
          gh<_i205.EditProfileUseCase>(),
          gh<_i728.UploadPhotoUseCase>(),
        ));
    gh.factory<_i494.GetCategoriesUseCase>(() => _i494.GetCategoriesUseCase(
          gh<_i427.GetCategoriesRepository>(),
          gh<_i427.GetProductsByIdRepository>(),
        ));
    gh.factory<_i680.ForgotPasswordCubit>(() => _i680.ForgotPasswordCubit(
          gh<_i371.ForgotPasswordUseCase>(),
          gh<_i603.VerifyResetCodeUseCase>(),
          gh<_i967.ResetPasswordUseCase>(),
        ));
    gh.factory<_i57.CategoriesCubit>(
        () => _i57.CategoriesCubit(gh<_i494.GetCategoriesUseCase>()));
    return this;
  }
}

class _$LoggerModule extends _i495.LoggerModule {}

class _$DioModule extends _i338.DioModule {}
