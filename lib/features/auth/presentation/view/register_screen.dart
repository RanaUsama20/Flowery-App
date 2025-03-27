import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/base_state/base_state.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/di/service_locator.dart';
import 'package:flowery_app/core/dialogs/app_dialogs.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flowery_app/core/utils/validator.dart';
import 'package:flowery_app/features/auth/data/model/request/register_request_model.dart';
import 'package:flowery_app/features/auth/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery_app/features/auth/presentation/view_model/cubit/register_state.dart';
import 'package:flowery_app/features/auth/presentation/widgets/section_select_gender.dart';
import 'package:flowery_app/generated/locale_keys.g.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late GlobalKey<FormState> _formKey;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  late RegisterCubit registerCubit;
  @override
  void initState() {
    registerCubit = serviceLocator.get<RegisterCubit>();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Authentication_SignUp.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: firstNameController,
                      style: theme.titleSmall,
                      decoration: InputDecoration(
                          label: Text(LocaleKeys.Authentication_FirstName.tr()),
                          hintText:
                              LocaleKeys.Authentication_EnterFirstName.tr()),
                      validator: (value) {
                        return Validator.validateName(value);
                      },
                    )),
                    SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: lastNameController,
                      style: theme.titleSmall,
                      decoration: InputDecoration(
                          label: Text(LocaleKeys.Authentication_LastName.tr()),
                          hintText:
                              LocaleKeys.Authentication_EnterLastName.tr()),
                      validator: (value) {
                        return Validator.validateName(value);
                      },
                    )),
                  ],
                ),
                SizedBox(height: 24),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  style: theme.titleSmall,
                  decoration: InputDecoration(
                    label: Text(LocaleKeys.Authentication_Email.tr()),
                    hintText: LocaleKeys.Authentication_EnterYourEmail.tr(),
                  ),
                  validator: (value) {
                    return Validator.validateEmail(value);
                  },
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      style: theme.titleSmall,
                      decoration: InputDecoration(
                          label: Text(LocaleKeys.Authentication_Password.tr()),
                          hintText:
                              LocaleKeys.Authentication_EnterYourPassword.tr()),
                      validator: (value) {
                        return Validator.validatePassword(value);
                      },
                    )),
                    SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: confirmController,
                      style: theme.titleSmall,
                      decoration: InputDecoration(
                          label: Text(LocaleKeys.Authentication_Confirm.tr()),
                          hintText:
                              LocaleKeys.Authentication_ConfirmPassword.tr()),
                      validator: (value) {
                        return Validator.validateConfirmPassword(
                            value, passwordController.text);
                      },
                    )),
                  ],
                ),
                SizedBox(height: 24),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: phoneNumberController,
                  style: theme.titleSmall,
                  decoration: InputDecoration(
                      label: Text(LocaleKeys.Authentication_PhoneNumber.tr()),
                      hintText:
                          LocaleKeys.Authentication_EnterPhoneNumber.tr()),
                  validator: (value) {
                    // return Validator.validatePhoneNumber(value);
                  },
                ),
                SizedBox(height: 24),
                SectionOfGenderWidget(
                  registerCubit: registerCubit,
                ),
                SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                    text: LocaleKeys
                        .Authentication_CreatingAnAccountYouAgreeToOur.tr(),
                    children: [
                      TextSpan(
                          text: LocaleKeys.Authentication_TermsConditions.tr(),
                          style: theme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline))
                    ],
                    style: theme.bodyLarge,
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: BlocListener<RegisterCubit, RegisterState>(
                      bloc: registerCubit,
                      listener: (context, state) {
                        if (state.registerState is BaseLoadingState) {
                          AppDialogs.showLoadingDialog(context);
                        } else if (state.registerState is BaseSuccessState) {
                          final ans = state.registerState as BaseSuccessState;
                          Navigator.of(context).pop();
                          AppDialogs.showSuccessDialog(context,
                              message: ans.data);
                        } else if (state.registerState is BaseErrorState) {
                          Navigator.of(context).pop();
                          final ans = state.registerState as BaseErrorState;
                          AppDialogs.showFailureDialog(context,
                              message: ans.errorMessage);
                        }
                      },
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              registerCubit.register(RegisterRequestModel(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword: confirmController.text,
                                  phoneNumber: phoneNumberController.text,
                                  gender: registerCubit.gender));
                            }
                          },
                          child: Text(LocaleKeys.Authentication_SignUp.tr())),
                    )),
                SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                      text: LocaleKeys.Authentication_AlreadyHaveAnAccount.tr(),
                      children: [
                        TextSpan(
                            text: LocaleKeys.Authentication_Login.tr(),
                            style: theme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.pink,
                                decorationColor: AppColors.pink,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamed(Routes.login);
                              })
                      ],
                      style: theme.titleSmall),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}