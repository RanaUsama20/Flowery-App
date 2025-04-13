import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/core/dialogs/app_toasts.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/utils/validator.dart';
import 'package:flowery_app/features/auth/presentation/view/email_verification_screen.dart';
import 'package:flowery_app/features/auth/presentation/view_model/forgot_password/forgot_password_state.dart';
import 'package:flowery_app/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../view_model/forgot_password/forgot_password_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.Authentication_Password.tr()),
      body: BlocListener<ForgotPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state.isForgotPasswordLoading) {
            AppDialogs.showLoadingDialog(context);
          }
          if (state.isForgotPasswordSuccess) {
            context.pop();

            context.pushNamed(Routes.emailVerification,
                arguments: context.read<ForgotPasswordCubit>());
          }
          if (state.isForgotPasswordError) {
            context.pop();
            AppToast.showToast(
              context: context,
              title: LocaleKeys.Authentication.tr(),
              description: LocaleKeys.Error_Unexpected_server_error.tr(),
              type: ToastificationType.error,
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(LocaleKeys.Authentication_TitleForgetPassword.tr(),
                  style: AppTheme.lightTheme.textTheme.titleLarge),
              SizedBox(height: context.hp(1.5)),
              Text(
                LocaleKeys.Authentication_SubtitleForgetPassword.tr(),
                style: AppTheme.lightTheme.textTheme.titleSmall
                    ?.copyWith(color: AppColors.gray),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.hp(3)),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.Authentication_Email.tr(),
                    labelStyle: AppTheme.lightTheme.inputDecorationTheme.labelStyle,
                    hintText: LocaleKeys.Authentication_EnterYourEmail.tr(),
                    hintStyle: AppTheme.lightTheme.inputDecorationTheme.hintStyle,
                    border: AppTheme.lightTheme.inputDecorationTheme.border,
                    focusedBorder: AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
                    errorBorder: AppTheme.lightTheme.inputDecorationTheme.errorBorder,
                    focusedErrorBorder:
                        AppTheme.lightTheme.inputDecorationTheme.focusedErrorBorder,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                  ),
                  validator: (val) => Validator.validateEmail(val),
                ),
              ),
              SizedBox(height: context.hp(5)),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<ForgotPasswordCubit>()
                        .forgotPassword(_emailController.text);
                  }
                },
                style: AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
                  minimumSize: WidgetStatePropertyAll(Size(double.infinity, 48)),
                ),
                child: Text(LocaleKeys.Authentication_Confirm.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late TextEditingController _emailController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }
}
