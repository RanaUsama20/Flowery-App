import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flowery_app/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/extentions/media_query_extensions.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/model/request/forgot_password_request.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}
final  TextEditingController codeController =TextEditingController();
late ForgotPasswordCubit forgotPasswordCubit;
class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();
  late ForgotPasswordCubit forgotPasswordCubit;

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
          if (state is ForgotPasswordLoadingSendState||state is ForgotPasswordLoadingReSendState) {
            // Show loading indicator or toast
            showDialog(
              context: context,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is ForgotPasswordSuccessState) {
            Navigator.of(context).pop();

            Navigator.of(context).pushNamed(Routes.resetPassword);
          } else if (state is ForgotPasswordFailureState) {
            Navigator.of(context).pop(); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          }
          else if (state is ForgotPasswordSuccessResendState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${state.message}')),
            );
          } else if (state is ForgotPasswordFailureState) {
            Navigator.of(context).pop(); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.arrow_back_ios_new_rounded, size: context.sp(25)),
                      ),
                      Text(" Password", style: AppTheme.lightTheme.textTheme.titleLarge),
                    ],
                  ),
                  SizedBox(height: context.hp(4)),
                  Text("Email verification", style: AppTheme.lightTheme.textTheme.titleLarge),
                  SizedBox(height: context.hp(1.5)),
                  Text(
                    "Please enter your code that was sent to",
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(color: AppColors.gray),
                  ),
                  Text(
                    "your email address",
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(color: AppColors.gray),
                  ),
                  SizedBox(height: context.hp(3.5)),
                  SizedBox(height: context.hp(3)),
                  TextFormField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter Your code",
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
                        return 'Code cannot be empty';
                      }
                      if (value.length < 6) {
                        return 'Code should be at least 6 digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: context.hp(5)),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        forgotPasswordCubit.sendResetCode(code: codeController.text);
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
                          'Submit',
                          style: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
        SizedBox(height: context.hp(3),),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Didn't receive code? ",style:AppTheme.lightTheme.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w400, color: AppColors.black),),
            InkWell(
              onTap: () {
                forgotPasswordCubit.resendCode();
              },
              child: Text("Resend",style:AppTheme.lightTheme.textTheme.labelLarge!.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.pink,      // Set the underline color
                  fontWeight: FontWeight.w400, color: AppColors.pink),),
            ),
                ],
              ),
            ]))
          ),
        ),
      ),
    );
  }
}
