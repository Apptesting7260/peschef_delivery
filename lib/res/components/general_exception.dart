import 'package:peschef_delivery/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  const GeneralExceptionWidget({Key? key, required this.onPress})
      : super(key: key);

  @override
  State<GeneralExceptionWidget> createState() => _GeneralExceptionWidgetState();
}

class _GeneralExceptionWidgetState extends State<GeneralExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: height * .15,
          ),
          Icon(
            Icons.cloud_off,
            color: AppColor.redColor,
            size: Get.height * 0.18,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
                child: Text(
              "Something went wrong please try again!!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'RammettoOne',
              ),
            )),
          ),
          SizedBox(
            height: height * .06,
          ),
          InkWell(
            onTap: widget.onPress,
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(214, 51, 72, 1),
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                  child: Text(
                'Retry',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'RammettoOne',
                    color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
