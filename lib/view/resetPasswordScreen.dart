import 'package:peschef_delivery/controller/resetPasswordController.dart';
import 'package:peschef_delivery/data/response/status.dart';
import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? token;
  ResetPasswordScreen({super.key, this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

final ResetPasswordController resetPasswordController =
    Get.put(ResetPasswordController());

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
                              'Reset Password',
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
                                  fontFamily: 'Poppins'),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
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
                      'New Password',
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
                  key: resetPasswordController.resetPassNewGlobalKey.value,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    child: TextFormField(
                      controller:
                          resetPasswordController.newPassController.value,
                      // style: Theme.of(context).textTheme.bodyMedium,
                      obscureText: resetPasswordController.isHidden.value,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: InkWell(
                              onTap: resetPasswordController.togglePasswordView,

                              /// This is Magical Function
                              child: Icon(
                                resetPasswordController.isHidden.value
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
                          hintText: 'Enter your new password',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(119, 119, 119, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins')),
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        } else {
                          if (!regex.hasMatch(value)) {
                            return 'At least one lowercase alphabet \nAt least one uppercase alphabet \nAt least one Numeric digit \nAt least one special character \nAlso, the total length must be greater than 8';
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.06,
                    ),
                    Text(
                      'Confirm Password',
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
                  key: resetPasswordController.resetPassConfirmGlobalKey.value,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                    child: TextFormField(
                      controller:
                          resetPasswordController.confirmPassController.value,
                      // style: Theme.of(context).textTheme.bodyMedium,
                      obscureText: resetPasswordController.isHidden2.value,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: InkWell(
                              onTap:
                                  resetPasswordController.togglePasswordView2,

                              /// This is Magical Function
                              child: Icon(
                                resetPasswordController.isHidden2.value
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
                          hintText: 'Enter password again',
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
                          if (!(resetPasswordController
                                  .newPassController.value.text ==
                              resetPasswordController
                                  .confirmPassController.value.text)) {
                            return 'Password not matched';
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    if (resetPasswordController
                            .resetPassNewGlobalKey.value.currentState!
                            .validate() &&
                        resetPasswordController
                            .resetPassConfirmGlobalKey.value.currentState!
                            .validate()) {
                      resetPasswordController.ResetPasswordApi(
                          widget.token.toString());
                    }
                  },
                  child: Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(60))),
                    child: Center(
                      child: (resetPasswordController.rxRequestStatus.value ==
                              Status.LOADING)
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Save',
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
