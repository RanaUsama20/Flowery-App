import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/model/request/forgot_password_request.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  late ForgotPasswordCubit forgotPasswordCubit;
  final _formKey = GlobalKey<FormState>();  // Add GlobalKey for form validation

  @override
  void initState() {
    super.initState();
    forgotPasswordCubit = serviceLocator.get<ForgotPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        bloc: forgotPasswordCubit,
        listener: (context, state) {
          if (state is ForgotPasswordLoadingState) {
            // Show loading indicator or toast
            showDialog(
              context: context,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is ForgotPasswordSuccessState) {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Routes.emailVerification);
          } else if (state is ForgotPasswordFailureState) {
            Navigator.of(context).pop(); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
            print("---------------------------");
            print(state.errorMessage);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_back_ios_new_rounded, size: context.sp(25)),
                    Text(" Password", style: AppTheme.lightTheme.textTheme.titleLarge),
                  ],
                ),
                SizedBox(height: context.hp(4)),
                Text("Forget Password", style: AppTheme.lightTheme.textTheme.titleLarge),
                SizedBox(height: context.hp(1.5)),
                Text(
                  "Please enter your email associated to",
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(color: AppColors.gray),
                ),
                Text(
                  " your account",
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(color: AppColors.gray),
                ),
                SizedBox(height: context.hp(3)),
                Form(  // Wrap the email field in a Form widget
                  key: _formKey,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.Authentication_Email.tr(),
                      labelStyle: AppTheme.lightTheme.inputDecorationTheme.labelStyle,
                      hintText: LocaleKeys.Authentication_EnterYourEmail.tr(),
                      hintStyle: AppTheme.lightTheme.inputDecorationTheme.hintStyle,
                      border: AppTheme.lightTheme.inputDecorationTheme.border,
                      focusedBorder: AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
                      errorBorder: AppTheme.lightTheme.inputDecorationTheme.errorBorder,
                      focusedErrorBorder: AppTheme.lightTheme.inputDecorationTheme.focusedErrorBorder,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Use a regex to check for valid email format
                      final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;  // Return null if the input is valid
                    },
                  ),
                ),
                SizedBox(height: context.hp(5)),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      forgotPasswordCubit.forgotPassword(ForgotPasswordRequest(email: emailController.text));
                    }
                  },
                  child: Container(
                    width: context.wp(90),
                    height: context.hp(5.6),
                    decoration: BoxDecoration(
                      color: AppColors.pink,
                      borderRadius: BorderRadius.circular(context.sp(40)),
                    ),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
