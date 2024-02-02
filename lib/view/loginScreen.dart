import 'package:peschef_delivery/controller/loginController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:peschef_delivery/view/forgotPasswordScreen.dart';
import 'package:peschef_delivery/view/tabBarView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  final LoginController loginController = Get.put(LoginController());

  // final signInGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: SingleChildScrollView(
          child: Column(
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
                      height: Get.height * 0.06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(width: Get.width*0.3,),
                        Container(
                            height: Get.height * 0.07,
                            width: Get.width * 0.45,
                            child: Image.asset('assets/images/Logo.png')),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(width: Get.width*0.3,),
                        Container(
                            child: Text(
                          'Welcome Back!',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'RammettoOne'),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     // SizedBox(width: Get.width*0.04,),
                    //     Container(
                    //       // width: Get.width * 0.9,
                    //       // height: Get.height * 0.058,

                    //       child: Row(
                    //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           // SizedBox(width: Get.width*0.0,),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   SizedBox(width: Get.width * 0.04),
                    //                   Container(
                    //                       height: Get.height * 0.04,
                    //                       child: Text(
                    //                         'Login',
                    //                         style: TextStyle(
                    //                             fontSize: 18,
                    //                             fontWeight: FontWeight.w400,
                    //                             fontFamily: 'RammettoOne',
                    //                             color: Color.fromRGBO(
                    //                                 214, 51, 72, 1)),
                    //                       )),
                    //                 ],
                    //               ),
                    //               Container(
                    //                 width: Get.width * 0.25,
                    //                 height: Get.height * 0.005,
                    //                 color: AppColor.primaryColor,
                    //               )
                    //             ],
                    //           ),

                    //           SizedBox(
                    //             width: Get.width * 0.2,
                    //           ),
                    //           GestureDetector(
                    //             onTap: () {
                    //               // Get.to(() => SignUpScreen());
                    //             },
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Container(
                    //                     height: Get.height * 0.04,
                    //                     child: Text(
                    //                       'Sign-Up',
                    //                       style: TextStyle(
                    //                           fontSize: 18,
                    //                           fontFamily: 'RammettoOne',
                    //                           fontWeight: FontWeight.w400,
                    //                           color:
                    //                               AppColor.secondaryColor),
                    //                     )),
                    //                 Container(
                    //                   width: Get.width * 0.25,
                    //                   height: Get.height * 0.005,
                    //                   color: Colors.white,
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              Form(
                key: loginController.signInGlobalKey.value,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * .05,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.06,
                        ),
                        Text(
                          'Email address',
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
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: TextFormField(
                        controller: loginController.emailController.value,
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
                    SizedBox(
                      height: Get.height * .03,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.06,
                        ),
                        Text(
                          'Password',
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
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: TextFormField(
                        controller: loginController.passController.value,
                        // style: Theme.of(context).textTheme.bodyMedium,
                        obscureText: _isHidden,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: InkWell(
                                onTap: _togglePasswordView,

                                /// This is Magical Function
                                child: Icon(
                                  _isHidden
                                      ?

                                      /// CHeck Show & Hide.
                                      Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
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
                            hintText: 'Enter password',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(119, 119, 119, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins')),
                        onFieldSubmitted: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SizedBox(width: Get.width*0.4,),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ForgotPasswordScreen());
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 27.0),
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: AppColor.primaryColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    if (loginController.signInGlobalKey.value.currentState!
                        .validate()) {
                      loginController.SignUpApi();
                    }

                    // Get.to(() => MyTabView());
                  },
                  child: Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(60))),
                    child: Center(
                      child: (loginController.rxRequestStatus.value ==
                              Status.LOADING)
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Log in',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'RammettoOne',
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              // Text(
              //   'Or',
              //   style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w400,
              //       fontFamily: 'RammettoOne',
              //       color: AppColor.secondaryColor),
              // ),
              // SizedBox(
              //   height: Get.height * 0.02,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //         height: Get.height * 0.05,
              //         width: Get.width * 0.1,
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle, color: Colors.white),
              //         child: Center(
              //             child: Image.asset(
              //           'assets/images/fb.jpg',
              //           height: Get.height * 0.03,
              //         ))),
              //     SizedBox(
              //       width: Get.width * 0.015,
              //     ),
              //     Container(
              //         height: Get.height * 0.05,
              //         width: Get.width * 0.1,
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle, color: Colors.white),
              //         child: Center(
              //             child: Image.asset(
              //           'assets/images/google.png',
              //           height: Get.height * 0.03,
              //         ))),
              //     SizedBox(
              //       width: Get.width * 0.015,
              //     ),
              //     Container(
              //         height: Get.height * 0.05,
              //         width: Get.width * 0.1,
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle, color: Colors.white),
              //         child: Center(
              //             child: Image.asset(
              //           'assets/images/apple.png',
              //           height: Get.height * 0.03,
              //         ))),
              //   ],
              // ),
              // SizedBox(
              //   height: Get.height * 0.07,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'You don\'t have an account yet?',
              //       style: TextStyle(
              //           fontSize: 14,
              //           fontWeight: FontWeight.w600,
              //           fontFamily: 'Poppins',
              //           color: AppColor.secondaryColor),
              //     ),
              //     SizedBox(
              //       width: Get.width * 0.01,
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         // Get.to(() => SignUpScreen());
              //       },
              //       child: Text(
              //         'Sign-Up',
              //         style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.w600,
              //             fontFamily: 'Poppins',
              //             color: AppColor.primaryColor),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: Get.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
