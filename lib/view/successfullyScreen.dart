import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:peschef_delivery/res/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessfullyScreen extends StatefulWidget {
  const SuccessfullyScreen({super.key});

  @override
  State<SuccessfullyScreen> createState() => _SuccessfullyScreenState();
}

class _SuccessfullyScreenState extends State<SuccessfullyScreen> {
  var _clicksuccessfull = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.23,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: Get.height * 0.18,
                      // width: Get.width*0.05,
                      child: Image.asset('assets/images/successfully.png')),
                ],
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: Get.width*0.3,),
                  Container(
                      child: Text(
                    'Successfully',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'RammettoOne'),
                  )),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Column(
                children: [
                  Container(
                      child: Text(
                    'You have successfully change your password\n and now you can continue with our services. \nPlease click on Continue!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins'),
                  )),
                ],
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _clicksuccessfull = true;
                  });
                  // Delay for 1 second before navigating to another page.
                  Future.delayed(Duration(seconds: 1), () {
                    Get.offAllNamed(RouteName.loginScreen);
                    setState(() {
                      _clicksuccessfull = false;
                    });
                  });
                },
                child: Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  child: Center(
                    child: (_clicksuccessfull)
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'RammettoOne',
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
