import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base_state/base_state.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_dialogs.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/validator.dart';
import '../../../../generated/locale_keys.g.dart';
import '../view_model/change_password/change_password_cubit.dart';
import '../view_model/change_password/change_password_state.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  late ChangePasswordCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = serviceLocator<ChangePasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:  (context) => cubit,
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state.baseState is BaseSuccessState) {
              Navigator.pushReplacementNamed(context, Routes.login);

              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   AppDialogs.showSuccessDialog(context,
              //       message:
              //           'Password changed successfully , you need to login again',
              //   );
              // });
            } else if (state.baseState is BaseErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppDialogs.showFailureDialog(
                  context,
                  message: (state.baseState as BaseErrorState).exception.toString(),
                );
              });
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: cubit.currentPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.Authentication_currentPassword.tr(),
                        labelText: LocaleKeys.Authentication_currentPassword.tr(),
                      ),
                      validator: (value) => Validator.validatePassword(value),
                      onTapOutside: (_) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: cubit.newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.Authentication_NewPassword.tr(),
                        labelText: LocaleKeys.Authentication_NewPassword.tr(),
                      ),
                      validator: (value) => Validator.validatePassword(value),
                      onTapOutside: (_) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.Authentication_ConfirmPassword.tr(),
                        labelText: LocaleKeys.Authentication_ConfirmPassword.tr(),
                      ),
                      validator: (value) => Validator.validateConfirmPassword(
                          value, cubit.newPasswordController.text),
                      onTapOutside: (_) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                    ),
                    const SizedBox(height: 48.0),
                    BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                      builder: (context, state) {
                        final isLoading = state.baseState is BaseLoadingState;
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.isFormValid
                                ? Theme.of(context).primaryColor
                                : AppColors.black[AppColors.colorCode30],
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (state.isFormValid) {
                                    cubit.doIntent(UpdatePasswordAction());
                                  }
                                },
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : Text(LocaleKeys.Profile_Update.tr()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
