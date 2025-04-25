import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/dialogs/app_toasts.dart';
import 'package:flowery_app/features/checkout/presentation/widgets/payment_method_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/base_state/base_state.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/network/common/api_result.dart';
import '../../../../core/routes/routes.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../cart/domain/entity/cart_data_entity.dart';
import '../../../categories/presentation/view/stripe_payment.dart';
import '../../domain/entity/response/cash_payment/cash_payment_response_entity.dart';
import '../../domain/entity/response/credit_card_payment/checkout_session_entity.dart';
import '../view_model/cubit/checkout_cubit.dart';
import '../view_model/cubit/checkout_state.dart';
import 'bottom_widget.dart';
import 'delivery_address_widget.dart';
import 'delivery_time_widget.dart';
import 'gift_widget.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({super.key, required this.price});
  final num price;

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> with WidgetsBindingObserver {
  late CheckoutCubit _checkoutCubit;
  String? _selectedAddressId;

  void _onAddressSelected(String id) {
    setState(() {
      _selectedAddressId = id;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkoutCubit = serviceLocator<CheckoutCubit>();
    _checkoutCubit.doIntent(GetAddressAction());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _checkoutCubit.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _checkoutCubit,
      child: BlocConsumer<CheckoutCubit, CheckoutStates>(
        listenWhen: (previous, current) => previous.paymentState != current.paymentState,
        listener: (context, state) {
          final paymentState = state.paymentState;

          if (paymentState is BaseLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          }
          if (paymentState is BaseHideLoadingState) {
            Navigator.of(context).pop();
          }
          if (paymentState is BaseSuccessState) {
            final result = paymentState.data;

            if (result is SuccessResult<CashPaymentResponseEntity?>) {
              AppToast.showToast(
                context: context,
                title: LocaleKeys.checkout_title_cash_payment_success.tr(),
                description: LocaleKeys.checkout_description_cash_payment_success.tr(),
                type: ToastificationType.success,
              );
              Navigator.of(context).pushNamed(Routes.appSection);
            }
            if (result is SuccessResult<CheckoutSessionEntity?>) {
              openStripeCheckout(result.data!.session.url, context);
            }

          }
          if (paymentState is BaseErrorState) {
            AppToast.showToast(
              context: context,
              title: LocaleKeys.checkout_title_cash_payment_fail.tr(),
              description: LocaleKeys.checkout_description_cash_payment_fail.tr(),
              type: ToastificationType.error,
            );
          }
        },
        builder: (context, state) {
          final selectedMethod = state.selectedPaymentMethod ?? "";

          return SingleChildScrollView(
            child: Column(
              children: [
                DeliveryTimeWidget(),
                SizedBox(height: 24),
                DeliveryAddressWidget(
                  checkoutCubit: _checkoutCubit,
                  onAddressSelected: _onAddressSelected,
                ),
                SizedBox(height: 24),
                PaymentMethodWidget(
                  selectedMethod: selectedMethod,
                  onMethodSelected: (method) {
                    _checkoutCubit.doIntent(SetPaymentMethodAction(method));
                  },
                ),
                SizedBox(height: 24),
                if (selectedMethod == LocaleKeys.checkout_Credit_card.tr())
                  GiftWidget(),
                SizedBox(height: 24),
                BottomWidget(
                  checkoutCubit: _checkoutCubit,
                  price: widget.price,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
Future<void> openStripeCheckout(String url, BuildContext context) async {
  final success = await Navigator.of(context).push<bool>(
    MaterialPageRoute(
      builder: (context) => StripeCheckoutScreen(
        checkoutUrl: url,
        successUrl: "http://localhost:3000/allOrders",
        cancelUrl: "http://localhost:3000/cart",
      ),
    ),
  );

  if (success == true) {
    AppToast.showToast(
      context: context,
      title: LocaleKeys.checkout_title_credit_payment_success.tr(),
      description: LocaleKeys.checkout_description_credit_payment_success.tr(),
      type: ToastificationType.success,
    );
    Navigator.of(context).pushNamed(Routes.appSection);
  } else {
    AppToast.showToast(
      context: context,
      title: LocaleKeys.checkout_title_cash_payment_fail.tr(),
      description: LocaleKeys.checkout_description_cash_payment_fail.tr(),
      type: ToastificationType.error,
    );
  }
}
// Future<void> openStripeCheckout(String url, BuildContext context) async {
//   final Uri uri = Uri.parse(url);
//
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(
//       uri,
//       mode: LaunchMode.externalApplication,
//     ).then((_) {
//       final cubit = BlocProvider.of<CheckoutCubit>(context);
//       cubit.getCartProducts();
//       Navigator.of(context).pop();
//     });
//   } else {
//     AppToast.showToast(
//       context: context,
//       title: LocaleKeys.checkout_title_cash_payment_fail.tr(),
//       description: LocaleKeys.checkout_description_cash_payment_fail.tr(),
//       type: ToastificationType.error,
//     );
//   }
// }
