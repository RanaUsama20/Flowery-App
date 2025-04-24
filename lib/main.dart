import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app/app_cubit/app_cubit_cubit.dart';
import 'core/constants/app_values.dart';
import 'core/di/service_locator.dart';
import 'core/routes/route_generator.dart';
import 'core/routes/routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_shared_preference.dart';
import 'core/utils/bloc_observer.dart';
import 'features/cart/presentation/view_model/cart_cubit.dart';
import 'features/profile/presentation/view_model/profile_main/profile_main_cubit.dart';

void main() async {
  //debugPrintRebuildDirtyWidgets = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    configureDependencies(),
    EasyLocalization.ensureInitialized(),
    SharedPreferencesUtils.init(),
  ]);
  Bloc.observer = MyBlocObserver();

  runApp(EasyLocalization(
    supportedLocales: AppValues.supportedLocales,
    fallbackLocale: AppValues.englishLocale,
    path: AppValues.pathTranslation,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final token = await SharedPreferencesUtils.getString(AppValues.token);
    setState(() {
      _isLoggedIn = token != null && token.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileMainCubit>(
          create: (_) => serviceLocator<ProfileMainCubit>()..getProfileData(),
        ),
        BlocProvider<AppCubit>(
          create: (_) => serviceLocator<AppCubit>(),
        ),
        BlocProvider(
        create: (context) => serviceLocator<CartCubit>(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppTheme.lightTheme,
        title: AppValues.appTitle,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: _isLoggedIn! ? Routes.appSection : Routes.login,
      ),
    );
  }
}
