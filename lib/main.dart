import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/utils/save_local.dart';
import 'package:flowery_app/features/auth/api/webServices/auth_retrofit_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/app_values.dart';
import 'core/di/service_locator.dart';
import 'core/routes/route_generator.dart';
import 'core/routes/routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await EasyLocalization.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  runApp(EasyLocalization(
    supportedLocales: AppValues.supportedLocales,
    fallbackLocale: AppValues.englishLocale,
    path: AppValues.pathTranslation,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints)  {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0),),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: AppTheme.lightTheme,
            title: AppValues.appTitle,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute:  isLogin()?Routes.home: Routes.login,
          ),
        );
      },
    );
  }

  bool  isLogin() {
     SaveLocal.getString("token").then((value){
       if(value!=null){
         return true;
       }else{
         return false;
       }
     });
     return true;
     }
}


