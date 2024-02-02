import 'dart:async';

import 'package:peschef_delivery/controller/forgotePasswordController.dart';
import 'package:peschef_delivery/controller/otpVerifyController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinput/pinput.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String? email;
  final String? type;
  EmailVerificationScreen({
    super.key,
    this.email,
    this.type,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

final OtpVerifyController otpVerifyController = Get.put(OtpVerifyController());
final ForgotPasswordController forgotPasswordController =
    Get.put(ForgotPasswordController());

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  // @override
  // void dispose() {
  //   otpVerifyController.pinController.value.dispose();
  //   otpVerifyController.focusNode.value.dispose();
  //   super.dispose();
  // }

  @override
  initState() {
    super.initState();
    forgotPasswordController.timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (forgotPasswordController.secondsRemaining.value != 0) {
        forgotPasswordController.secondsRemaining.value--;
      } else {
        setState(() {
          forgotPasswordController.enableResend.value = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColor.secondaryColor;
    // const fillColor = Color.fromRGBO(243, 246, 249, 0);
    // const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: Get.width * 0.13,
      height: Get.width * 0.13,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Colors.white,
        // border: Border.all(color: borderColor),
      ),
    );

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
                              'Verification',
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
                              'We sent verification OTP to ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: Color.fromRGBO(119, 119, 119, 1)),
                            )),
                            Container(
                                child: Text(
                              widget.email.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                              ),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                      ],
                    )),

                SizedBox(
                  height: Get.height * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: Get.width*0.06,),
                    Text(
                      'Enter Verification Code',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'RammettoOne',
                          color: AppColor.secondaryColor),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Form(
                  key: otpVerifyController.formKey.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Directionality(
                        // Specify direction if desired
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          length: 6,
                          controller: otpVerifyController.pinController.value,
                          focusNode: otpVerifyController.focusNode.value,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: defaultPinTheme,
                          closeKeyboardWhenCompleted: true,

                          separatorBuilder: (index) => const SizedBox(width: 8),
                          // validator: (value) {
                          //   return value == '222222' ? null : 'Wrong OTP';
                          // },
                          onClipboardFound: (value) {
                            debugPrint('onClipboardFound: $value');
                            otpVerifyController.pinController.value
                                .setText(value);
                          },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            debugPrint('onCompleted: $pin');
                            otpVerifyController.otp.value = pin;
                          },
                          onChanged: (value) {
                            debugPrint('onChanged: $value');
                            otpVerifyController.otp.value = value;
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 15,
                                ),
                                width: 2,
                                height: 22,
                                color: focusedBorderColor,
                              ),
                            ],
                          ),
                          // focusedPinTheme: defaultPinTheme.copyWith(
                          //   decoration: defaultPinTheme.decoration!.copyWith(
                          //     borderRadius: BorderRadius.circular(8),
                          //     border: Border.all(color: focusedBorderColor),
                          //   ),
                          // ),
                          // submittedPinTheme: defaultPinTheme.copyWith(
                          //   decoration: defaultPinTheme.decoration!.copyWith(
                          //     color: fillColor,
                          //     borderRadius: BorderRadius.circular(60),
                          //     border: Border.all(color: focusedBorderColor),
                          //   ),
                          // ),
                          // errorPinTheme: defaultPinTheme.copyBorderWith(
                          //   border: Border.all(color: Colors.redAccent),
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    //    setState(() {
                    //         _clickverifyEmail=true;
                    //       });
                    //   focusNode.unfocus();
                    //     // formKey.currentState!.validate();

                    //     Future.delayed(Duration(seconds: 1), () {

                    //     if (formKey.currentState!.validate()) {
                    //        Get.to(()=>PhoneVerificationScreen());
                    //     }
                    //  setState(() {
                    //         _clickverifyEmail=false;
                    //       });
                    //   });
                    otpVerifyController.OtpVerifyApi(
                        widget.email.toString(), widget.type.toString());
                  },
                  child: Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(60))),
                    child: Center(
                      child: (otpVerifyController.rxRequestStatus.value ==
                              Status.LOADING)
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Verify',
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
                //  SizedBox(height: Get.height*0.06,),

                (forgotPasswordController.rxRequestStatus.value ==
                        Status.LOADING)
                    ? CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t receive the OTP?',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: AppColor.secondaryColor),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (forgotPasswordController.enableResend.value) {
                                forgotPasswordController.ForgotPasswordApi(
                                    widget.email.toString());
                                forgotPasswordController.resendCode();
                              }
                            },
                            child: Obx(
                              () => Text(
                                forgotPasswordController.enableResend.value
                                    ? 'Resend'
                                    : ' Wait for ${(forgotPasswordController.secondsRemaining.value > 60) ? "01:${forgotPasswordController.secondsRemaining.value - 60}" : "00:${forgotPasswordController.secondsRemaining.value}"} minutes',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    color: AppColor.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
