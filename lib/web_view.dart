import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class FullscreenWebView extends StatefulWidget {
  final Function onSuccess;
  const FullscreenWebView({super.key, required this.onSuccess});

  @override
  State<FullscreenWebView> createState() => _FullscreenWebViewState();
}

class _FullscreenWebViewState extends State<FullscreenWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void dispose() {
    super.dispose();
  }

  String url =
      'https://demo-onboarding.incodesmile.com/bullb529/flow/64f97983ad556e6d41ae4fbd?region=ALL';

  // String url =
  //     'https://www.bullbitcoin.com/?flowId=64f97983ad556e6d41ae4fbd&interviewId=64f9da8fba17800c83d6d962';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                url: Uri.parse(url),
              ),
              initialOptions: options,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                // TODO: Move it to a variable
                if (url?.host == "www.bullbitcoin.com") {
                  controller.stopLoading();

                  if (url != null) {
                    Map<String, String> queryParams = url.queryParameters;
                    widget.onSuccess(
                      queryParams['flowId'],
                      queryParams['interviewId'],
                    );
                  }

                  Navigator.of(context).pop();
                }
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!;

                if (![
                  "http",
                  "https",
                  "file",
                  "chrome",
                  "data",
                  "javascript",
                  "about"
                ].contains(uri.scheme)) {
                  Uri uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    // Launch the App
                    await launchUrl(
                      uri,
                    );
                    // and cancel the request
                    return NavigationActionPolicy.CANCEL;
                  }
                }

                return NavigationActionPolicy.ALLOW;
              },
            ),
          )
        ]),
      ),
    );
  }
}
