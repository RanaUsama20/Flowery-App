import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/features/auth/presentation/presentation_login/view_model/login_cubit.dart';
import 'package:flowery_app/features/auth/presentation/presentation_login/view_model/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/dialogs/app_dialogs.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/locale_keys.g.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool isPassword = true;
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          AppDialogs.showSuccessDialog(context, message: state.message);
          Navigator.pushNamed(context, 'home');
        }else if (state is LoginLoadingState){
          AppDialogs.showLoadingDialog(context);
        } else if (state is LoginErrorState) {
          AppDialogs.showFailureDialog(context, message: state.error.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.Authentication_Login.tr()),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  validator: (val) => Validator.validateEmail(val),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.Authentication_Email.tr(),
                    hintText: LocaleKeys.Authentication_EnterYourEmail.tr(),
                  ),
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  obscureText: isPasswordVisible,
                  controller: passwordController,
                  validator: (val) =>
                      Validator.validatePassword(val),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    suffixIcon: isPassword
                        ? IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    )
                        : null,
                    labelText: LocaleKeys.Authentication_Password.tr(),
                    hintText: LocaleKeys.Authentication_EnterYourPassword.tr(),
                  ),
                  onTapOutside: (_) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() => rememberMe = value!);
                      },
                    ),
                    Text(
                      LocaleKeys.Authentication_RememberMe.tr(),
                      style: AppTheme.lightTheme.textTheme.bodyLarge,
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(LocaleKeys.Authentication_ForgetPassword.tr(),
                          style: AppTheme.lightTheme.textTheme.bodyLarge),
                    )
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
                    minimumSize:
                    MaterialStatePropertyAll(Size(double.infinity, 50)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  onPressed: () {
                    context.read<LoginCubit>().login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  },
                  child: Text(LocaleKeys.Authentication_Login.tr(),
                      style: AppTheme.lightTheme.textTheme.titleSmall
                          ?.copyWith(color: AppColors.white)),
                ),
                SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {},
                  child: Text(LocaleKeys.Authentication_ContinueAsGuest.tr(),
                      style: AppTheme.lightTheme.textTheme.titleSmall
                          ?.copyWith(color: AppColors.gray)),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.register);
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: LocaleKeys.Authentication_DonotHaveAnAccount.tr(),
                        style: AppTheme.lightTheme.textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: LocaleKeys.Authentication_SignUp.tr(),
                        style: AppTheme.lightTheme.textTheme.titleSmall
                            ?.copyWith(color: AppColors.pink),
                      )
                    ]),
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
