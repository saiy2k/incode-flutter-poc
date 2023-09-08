import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FullscreenWebView extends StatefulWidget {
  const FullscreenWebView({super.key});

  @override
  State<FullscreenWebView> createState() => _FullscreenWebViewState();
}

class _FullscreenWebViewState extends State<FullscreenWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://demo-onboarding.incodesmile.com/bullb529/flow/64f97983ad556e6d41ae4fbd?region=ALL',
        ),
      );
    // #enddocregion webview_controller
  }

  // #docregion webview_widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: WebViewWidget(controller: controller),
    );
  }
  // #enddocregion webview_widget
}
