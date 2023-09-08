import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'web_view_fullscreen.dart';
import 'web_view.dart';

///
///
/// ! NOTE:
/// Need to add platform permissions. Check - https://stackoverflow.com/a/55999932
///

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  await Permission.camera.request();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String url = "https://example.com"; // Replace with your desired URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Web View"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the fullscreen web view page
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FullscreenWebView(
                    onSuccess: (String flowId, String interviewId) {
                  print("onSuccess :: $flowId, $interviewId");
                }),
              ),
            );
          },
          child: Text("Open Fullscreen Web View"),
        ),
      ),
    );
  }
}
