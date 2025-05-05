import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/core/dialogs/app_toasts.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/theme/app_theme.dart';
import 'package:flowery_app/core/utils/validator.dart';
import 'package:flowery_app/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/extentions/media_query_extensions.dart';
import '../view_model/forgot_password/forgot_password_cubit.dart';
import '../view_model/forgot_password/forgot_password_state.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.Authentication_Password.tr()),
      body: BlocConsumer<ForgotPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state.isVerifyResetCodeLoading) {
            AppDialogs.showLoadingDialog(context);
          }
         else  if (state.isVerifyResetCodeSuccess) {
            context.pop();
            context.pushNamed(Routes.resetPassword,
                arguments: context.read<ForgotPasswordCubit>());
          }
          else if (state.isVerifyResetCodeError) {
            context.pop();
            AppToast.showToast(
              context: context,
              title: LocaleKeys.Authentication.tr(),
              description: LocaleKeys.Error_Unexpected_server_error.tr(),
              type: ToastificationType.error,
            );
          }
         else  if (state.isForgotPasswordSuccess) {
            context.pop();
            context.pop();
            AppToast.showToast(
              context: context,
              title: LocaleKeys.Authentication_Done.tr(),
              description: LocaleKeys.Authentication_DoneSedCode.tr(),
              type: ToastificationType.success,
            );
          }
          else if (state.isForgotPasswordLoading) {
            AppDialogs.showLoadingDialog(context);
          }
         else  if (state.isForgotPasswordError) {
            context.pop();
            AppToast.showToast(
              context: context,
              title: LocaleKeys.Authentication.tr(),
              description: LocaleKeys.Error_Unexpected_server_error.tr(),
              type: ToastificationType.error,
            );
          }
        },
        builder: (context, state) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(LocaleKeys.Authentication_EmailVerification.tr(),
                    style: AppTheme.lightTheme.textTheme.titleLarge),
                SizedBox(height: context.hp(1.5)),
                Text(
                  LocaleKeys.Authentication_SubEmailVerification.tr(),
                  style: AppTheme.lightTheme.textTheme.titleSmall
                      ?.copyWith(color: AppColors.gray),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.hp(3.5)),
                TextFormField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.Authentication_EnterCode.tr(),
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
                  validator: (value) => Validator.validateCode(value),
                ),
                SizedBox(height: context.hp(5)),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<ForgotPasswordCubit>()
                          .verifyResetCode(_codeController.text);
                    }
                  },
                  style: AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
                    minimumSize: WidgetStatePropertyAll(Size(double.infinity, 48)),
                  ),
                  child: Text(LocaleKeys.Authentication_Confirm.tr()),
                ),
                SizedBox(height: context.hp(3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.Authentication_DidnotReceiveCode.tr(),
                      style: AppTheme.lightTheme.textTheme.labelLarge!
                          .copyWith(fontWeight: FontWeight.w400, color: AppColors.black),
                    ),
                    InkWell(
                      onTap: () =>
                          context.read<ForgotPasswordCubit>().forgotPassword(state.email),
                      child: Text(
                        LocaleKeys.Authentication_Resend.tr(),
                        style: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.pink, // Set the underline color
                          fontWeight: FontWeight.w400,
                          color: AppColors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  late GlobalKey<FormState> _formKey;
  late TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
