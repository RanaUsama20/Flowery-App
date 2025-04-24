import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeCheckoutScreen extends StatefulWidget {
  final String checkoutUrl;
  final String successUrl;
  final String cancelUrl;

  const StripeCheckoutScreen({
    required this.checkoutUrl,
    required this.successUrl,
    required this.cancelUrl,
    super.key,
  });

  @override
  State<StripeCheckoutScreen> createState() => _StripeCheckoutScreenState();
}

class _StripeCheckoutScreenState extends State<StripeCheckoutScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.successUrl)) {
              Navigator.of(context).pop(true); // Payment success
              return NavigationDecision.prevent;
            } else if (request.url.startsWith(widget.cancelUrl)) {
              Navigator.of(context).pop(false); // Payment canceled
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}