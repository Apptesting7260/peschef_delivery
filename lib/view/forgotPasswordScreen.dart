import 'package:peschef_delivery/controller/forgotePasswordController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

final ForgotPasswordController forgotPasswordController =
    Get.put(ForgotPasswordController());

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(width: Get.width*0.3,),
                            Container(
                                child: Text(
                              'Forgot Password?',
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
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // SizedBox(width: Get.width*0.3,),
                            Container(
                                child: Text(
                              'Lorem Ipsum is simply dummy text of \nthe printing and typesetting industry.',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: Color.fromRGBO(119, 119, 119, 1)),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                      ],
                    )),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.06,
                    ),
                    Text(
                      'Email Address',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'RammettoOne',
                          color: AppColor.secondaryColor),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.008,
                ),
                Form(
                  key: _forgotGlobalKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    child: TextFormField(
                      controller:
                          forgotPasswordController.emailController.value,
                      // style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: Get.width * .045,
                              vertical: Get.height * .016),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(35.0)),
                            borderSide:
                                BorderSide(color: AppColor.secondaryColor),
                          ),
                          hintText: 'Enter email address',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(119, 119, 119, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins')),
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        const pattern =
                            r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                            r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                            r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                            r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                            r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                            r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                            r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                        final regex = RegExp(pattern);
                        if (value == null ||
                            value.isEmpty ||
                            !regex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    if (_forgotGlobalKey.currentState!.validate()) {
                      forgotPasswordController.ForgotPasswordApi(
                          forgotPasswordController.emailController.value.text);
                    }
                  },
                  child: Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(60))),
                    child: Center(
                      child: (forgotPasswordController.rxRequestStatus.value ==
                              Status.LOADING)
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Send',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'RammettoOne',
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
