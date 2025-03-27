import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';

class ResetPasswordScreen extends StatefulWidget{
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

final TextEditingController newPasswordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();

late ForgotPasswordCubit forgotPasswordCubit;

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  void initState() {
    super.initState();
    forgotPasswordCubit = serviceLocator.get<ForgotPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
    body:
      BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      bloc: forgotPasswordCubit,
      listener: (context, state) {
         if (state is ForgotPasswordLoadingResetState) {
           // Show loading indicator or toast
           showDialog(
             context: context,
             builder: (_) => const Center(child: CircularProgressIndicator()),
           );
         } else

          if (state is ForgotPasswordSuccessResetState) {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Routes.login);
        } else if (state is ForgotPasswordFailureResetState) {
          Navigator.of(context).pop(); // Close the loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errorMessage}')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: context.sp(25),
                        )),
                    Text(
                      LocaleKeys.Authentication_Password.tr(),
                      style: AppTheme.lightTheme.textTheme.titleLarge,
                    ),
                  ],
                ),
                SizedBox(height: context.hp(4)),
                Text(
                  LocaleKeys.Authentication_ResetPassword.tr(),
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                SizedBox(height: context.hp(1.5)),
                Text(
                  "Password must not be empty and must contain",
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(color: AppColors.gray),
                ),
                Text(
                  "6 characters with upper case letter and one",
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(color: AppColors.gray),
                ),
                Text(
                  "number at least",
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(color: AppColors.gray),
                ),
                SizedBox(height: context.hp(3.5)),
                TextFormField(
                  controller: newPasswordController,
                  obscureText: true, // Make sure password is obscured
                  decoration: InputDecoration(
                    labelText: LocaleKeys.Authentication_NewPassword.tr(),
                    labelStyle: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(color: AppColors.gray),
                    hintText: LocaleKeys.Authentication_EnterYourPassword.tr(),
                    hintStyle: AppTheme.lightTheme.inputDecorationTheme.labelStyle!.copyWith(
                      fontSize: context.sp(16),
                      color: Color(0xFFA6A6A6),
                    ),
                    border: AppTheme.lightTheme.inputDecorationTheme.border,
                    focusedBorder: AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
                    errorBorder: AppTheme.lightTheme.inputDecorationTheme.errorBorder,
                    focusedErrorBorder: AppTheme.lightTheme.inputDecorationTheme.focusedErrorBorder,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: context.hp(2.5)),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true, // Make sure password is obscured
                  decoration: InputDecoration(
                    labelText: LocaleKeys.Authentication_ConfirmPassword.tr(),
                    labelStyle: AppTheme.lightTheme.inputDecorationTheme.labelStyle,
                    hintText: LocaleKeys.Authentication_ConfirmPassword.tr(),
                    hintStyle: AppTheme.lightTheme.inputDecorationTheme.hintStyle,
                    border: AppTheme.lightTheme.inputDecorationTheme.border,
                    focusedBorder: AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
                    errorBorder: AppTheme.lightTheme.inputDecorationTheme.errorBorder,
                    focusedErrorBorder: AppTheme.lightTheme.inputDecorationTheme.focusedErrorBorder,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: context.hp(4.5)),
                InkWell(
                  onTap: () {
                    forgotPasswordCubit.verifyResetPassword( newPassword: newPasswordController.text, confirmPassword:confirmPasswordController.text);
            
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
                        LocaleKeys.Authentication_Confirm.tr(),
                        style: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),),
    );
  }
}
