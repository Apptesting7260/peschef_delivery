import 'package:peschef_delivery/splashServices/splash_services.dart';
import 'package:peschef_delivery/view/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   Future.delayed(const Duration(milliseconds: 3000), () {
  //     Get.to(() => LoginScreen());
  //   });
  //   super.initState();
  // }
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1,
              child: Image.asset(
                'assets/images/splash.jpg',
                fit: BoxFit.cover,
              ))),
    );
  }
}
