import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/features/app_section/app_section.dart';
import 'package:flowery_app/features/auth/presentation/view/email_verification_screen.dart';
import 'package:flowery_app/features/auth/presentation/view/guest_screen.dart';
import 'package:flowery_app/features/auth/presentation/view/register_screen.dart';
import 'package:flowery_app/features/auth/presentation/view/reset_password_screen.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/view/forget_password_screen.dart';
import '../../features/auth/presentation/view/login_screen.dart';

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case Routes.emailVerification:
        return MaterialPageRoute(
            builder: (_) => const EmailVerificationScreen());
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case Routes.guest:
        return MaterialPageRoute(builder: (_) => const GuestScreen());
      case Routes.appSection:
        return MaterialPageRoute(builder: (_) => const AppSection());
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
