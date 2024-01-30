import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var loadingPercentage = 0;

class _HomePageState extends State<HomePage> {
  @override
  late final WebViewController controller;
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          loadingPercentage = 100;
        },
        onNavigationRequest: (navigation) {
          final host = Uri.parse(navigation.url).host;
          if (host.contains("youtube.com")) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Blocking navigation to $host")));
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse("https://www.myntra.com/"));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              WebViewWidget(controller: controller),
              if (loadingPercentage < 100)
                LinearProgressIndicator(
                  value: loadingPercentage / 100,
                )
            ],
          ),
        ),
      ),
    );
  }
}
