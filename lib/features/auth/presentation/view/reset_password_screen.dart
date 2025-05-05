import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/core/dialogs/app_toasts.dart';
import 'package:flowery_app/core/extentions/media_query_extensions.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/utils/validator.dart';
import 'package:flowery_app/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../view_model/forgot_password/forgot_password_cubit.dart';
import '../view_model/forgot_password/forgot_password_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.Authentication_Password.tr()),
      body: BlocListener<ForgotPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state.isResetPasswordLoading) {
            AppDialogs.showLoadingDialog(context);
          }
          if (state.isResetPasswordSuccess) {
            context.pop();
            context.pushNamed(Routes.login);
          }
          if (state.isResetPasswordError) {
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  LocaleKeys.Authentication_ResetPassword.tr(),
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                SizedBox(height: context.hp(1.5)),
                Text(
                  LocaleKeys.Authentication_PasswordRequirements.tr(),
                  style: AppTheme.lightTheme.textTheme.titleSmall
                      ?.copyWith(color: AppColors.gray),
                ),
                SizedBox(height: context.hp(3.5)),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: true, // Make sure password is obscured
                  decoration: InputDecoration(
                    labelText: LocaleKeys.Authentication_NewPassword.tr(),
                    labelStyle: AppTheme.lightTheme.textTheme.labelLarge!
                        .copyWith(color: AppColors.gray),
                    hintText: LocaleKeys.Authentication_EnterYourPassword.tr(),
                    hintStyle:
                        AppTheme.lightTheme.inputDecorationTheme.labelStyle!.copyWith(
                      fontSize: context.sp(16),
                      color: Color(0xFFA6A6A6),
                    ),
                    border: AppTheme.lightTheme.inputDecorationTheme.border,
                    focusedBorder: AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
                    errorBorder: AppTheme.lightTheme.inputDecorationTheme.errorBorder,
                    focusedErrorBorder:
                        AppTheme.lightTheme.inputDecorationTheme.focusedErrorBorder,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) => Validator.validatePassword(value),
                ),
                SizedBox(height: context.hp(2.5)),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true, // Make sure password is obscured
                  decoration: InputDecoration(
                    labelText: LocaleKeys.Authentication_ConfirmPassword.tr(),
                    labelStyle: AppTheme.lightTheme.inputDecorationTheme.labelStyle,
                    hintText: LocaleKeys.Authentication_ConfirmPassword.tr(),
                    hintStyle: AppTheme.lightTheme.inputDecorationTheme.hintStyle,
                    border: AppTheme.lightTheme.inputDecorationTheme.border,
                    focusedBorder: AppTheme.lightTheme.inputDecorationTheme.focusedBorder,
                    errorBorder: AppTheme.lightTheme.inputDecorationTheme.errorBorder,
                    focusedErrorBorder:
                        AppTheme.lightTheme.inputDecorationTheme.focusedErrorBorder,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      Validator.validateConfirmPassword(value, _newPasswordController.text),
                ),
                SizedBox(height: context.hp(4.5)),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<ForgotPasswordCubit>()
                          .resetPassword(_newPasswordController.text);
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
      ),
    );
  }

  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  late GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
