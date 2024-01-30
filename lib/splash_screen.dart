// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:webviewapp/home_page.dart';

class SplashScrn extends StatefulWidget {
  const SplashScrn({super.key});

  @override
  State<SplashScrn> createState() => _SplashScrnState();
}

bool userlogged = false;

class _SplashScrnState extends State<SplashScrn> {
  @override
  void initState() {
    splashTime(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 247, 247),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 90, right: 90, top: 190),
          child: Column(children: [
            SizedBox(
              width: size.width,
              height: size.height / 2,
              child: Image.asset(
                filterQuality: FilterQuality.medium,
                "assets/images/logo-myntra-41467.png",
              ),
            ),
            const SizedBox(height: 15),
          ]),
        ),
      ),
    );
  }

  void splashTime(BuildContext contex) async {
    await Future.delayed(const Duration(milliseconds: 600));

    Navigator.of(contex).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
