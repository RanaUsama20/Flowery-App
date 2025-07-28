import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/features/auth/presentation/view/email_verification_screen.dart';
import 'package:flowery_app/features/auth/presentation/view/register_screen.dart';
import 'package:flowery_app/features/auth/presentation/view/reset_password_screen.dart';
import 'package:flowery_app/features/auth/presentation/view_model/forgot_password/forgot_password_cubit.dart';
import 'package:flowery_app/features/home/presentation/view/best_seller_screen.dart';
import 'package:flowery_app/features/home/presentation/view/occasion_screen.dart';
import 'package:flowery_app/features/notification/presentation/view/notification_screen.dart';
import 'package:flowery_app/features/product_details/presentation/models/product_details_model.dart';
import 'package:flowery_app/features/product_details/presentation/pages/product_details.dart';
import 'package:flowery_app/features/profile/presentation/view/Terms_and_condition_screen.dart';
import 'package:flowery_app/features/profile/presentation/view/about_app_screen.dart';
import 'package:flowery_app/features/profile/presentation/view/profile_screen.dart';
import 'package:flowery_app/features/search/presentation/view/main_search_screen.dart';
import 'package:flowery_app/features/search/presentation/view_model/bloc/search_bloc.dart';
import 'package:flowery_app/features/profile/presentation/view/saved_adreess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/address/presentation/view/address_screen.dart';
import '../../features/app_section/app_section.dart';
import '../../features/auth/data/model/request/edit_profile_request.dart';
import '../../features/auth/presentation/view/edit_profile_screen.dart';
import '../../features/auth/presentation/view/forget_password_screen.dart';
import '../../features/auth/presentation/view/login_screen.dart';
import '../../features/auth/presentation/view_model/login/login_cubit.dart';
import '../../features/cart/presentation/view_model/cart_cubit.dart';
import '../../features/categories/presentation/view/categories_screen.dart';
import '../../features/categories/presentation/view/sucess_page.dart';
import '../../features/checkout/presentation/view/checkout_screen.dart';
import '../../features/home/presentation/view/home_screen.dart';
import '../../features/profile/presentation/view/change_password_screen.dart';
import '../../features/profile/presentation/view/orders_screen.dart';
import '../di/service_locator.dart';

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    final arg = settings.arguments;
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
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => serviceLocator<ForgotPasswordCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );
      case Routes.emailVerification:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: arg as ForgotPasswordCubit,
            child: const EmailVerificationScreen(),
          ),
        );
      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: arg as ForgotPasswordCubit,
            child: ResetPasswordScreen(),
          ),
        );
      case Routes.appSection:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [BlocProvider(create: (context) => serviceLocator<CartCubit>())],
            child: const AppSection(),
          ),
        );
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.successPage:
        return MaterialPageRoute(builder: (_) => const SuccessPage());
      case Routes.occasion:
        return MaterialPageRoute(builder: (_) => const OccasionScreen());
      case Routes.bestSeller:
        return MaterialPageRoute(builder: (_) => const BestSellerScreen());
      case Routes.order:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case Routes.categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case Routes.checkout:
        final price = settings.arguments as num;
        return MaterialPageRoute(
          builder: (_) => CheckoutScreen(price: price),
        );
      case Routes.mainProfile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.productDetails:
        final product = settings.arguments as ProductDetailsModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetails(product: product),
        );
      case Routes.editProfile:
        return MaterialPageRoute(
          builder: (_) => EditProfileScreen(userData: arg as EditProfileRequest),
        );
      case Routes.address:
        return MaterialPageRoute(builder: (_) => AddressScreen());

      case Routes.savedAddress:
        return MaterialPageRoute(builder: (_) => SavedAddress());
      case Routes.aboutApp:
        return MaterialPageRoute(builder: (_) => AboutAppScreen());
      case Routes.termsAndCondition:
        return MaterialPageRoute(builder: (_) => const TermsAndConditionScreen());

      case Routes.search:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SearchBloc>(
            create: (context) => serviceLocator<SearchBloc>(),
            child: const SearchScreen(),
          ),
        );

      case Routes.notification:
        return MaterialPageRoute(builder: (_) => NotificationScreen());

      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
