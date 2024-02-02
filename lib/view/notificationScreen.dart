import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

List<bool> items = [true, false, true, false, false, true];

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.1),
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 10),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      width: Get.width * 0.13,
                      height: Get.width * 0.13,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(17),
                          )),
                      child: Center(
                          child: Image.asset(
                        'assets/images/arrow_b.png',
                        height: Get.height * 0.025,
                      ))),
                ),
                SizedBox(
                  width: Get.width * 0.08,
                ),
                Container(
                    child: Text(
                  'Notification',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'RammettoOne'),
                )),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),

              Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    // controller: scrollController,
                    itemCount: items.length,
                    itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 15),
                          child: Container(
                            height: Get.height * 0.12,
                            width: Get.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Center(
                              child: ListTile(
                                leading: (items[i])
                                    ? CircleAvatar(
                                        radius: Get.width * 0.075,
                                        backgroundImage: AssetImage(
                                            "assets/images/good_s.png"),
                                        backgroundColor: Colors.transparent,
                                      )
                                    : CircleAvatar(
                                        radius: Get.width * 0.075,
                                        backgroundImage: NetworkImage(
                                            "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fHww&w=1000&q=80"),
                                        backgroundColor: Colors.transparent,
                                      ),
                                title: (items[i])
                                    ? Text(
                                        'Your order is completed!',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            color:
                                                Color.fromRGBO(9, 64, 94, 1)),
                                      )
                                    : Text(
                                        'Dear customer your delivery arrive on 11PM',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            color:
                                                Color.fromRGBO(9, 64, 94, 1)),
                                      ),
                                subtitle: Text(
                                  '5 minutes ago',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      color: Color.fromRGBO(119, 119, 119, 1)),
                                ),
                              ),
                            ),
                          ),
                        )),
              ),
              // SizedBox(height: Get.height*0.1,)
            ],
          ),
        ),
      ),
    );
  }
}
