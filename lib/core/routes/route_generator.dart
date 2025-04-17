import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/features/auth/presentation/view/email_verification_screen.dart';
import 'package:flowery_app/features/auth/presentation/view/register_screen.dart';
import 'package:flowery_app/features/auth/presentation/view/reset_password_screen.dart';
import 'package:flowery_app/features/product_details/presentation/pages/product_details.dart';
import 'package:flowery_app/features/product_details/presentation/models/product_details_model.dart';
import 'package:flowery_app/features/home/presentation/view/best_seller_screen.dart';
import 'package:flowery_app/features/home/presentation/view/occasion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/app_section/app_section.dart';
import '../../features/auth/presentation/view/login_screen.dart';
import '../../features/auth/presentation/view_model/cubit/login_cubit.dart';
import '../../features/auth/presentation/view/forget_password_screen.dart';
import '../../features/cart/presentation/pages/cart_screen.dart';
import '../../features/categories/presentation/view/categories_screen.dart';
import '../../features/categories/presentation/view_model/cubit/categories_cubit.dart';
import '../../features/home/presentation/view/home_screen.dart';
import '../di/service_locator.dart';

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => serviceLocator<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) =>  ForgetPasswordScreen());
      case Routes.emailVerification:
        return MaterialPageRoute(
            builder: (_) => const EmailVerificationScreen());
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case Routes.appSection:
        return MaterialPageRoute(builder: (_) => const AppSection());

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.occasion:
        return MaterialPageRoute(builder: (_) => const OccasionScreen());
      case Routes.bestSeller:
        return MaterialPageRoute(builder: (_) => const BestSellerScreen());
      case Routes.categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case Routes.productDetails:
        final product = settings.arguments as ProductDetailsModel;
        return MaterialPageRoute(builder: (_) =>  ProductDetails(
          product: product,
        ));
      case Routes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
        return MaterialPageRoute(builder: (_) =>
            ProductDetails(
              product: product,
            ));
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          Scaffold(
            appBar: AppBar(title: Text('No Route Found')),
            body: const Center(child: Text('No Route Found')),
          ),
    );
  }
}
