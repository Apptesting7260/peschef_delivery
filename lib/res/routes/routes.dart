import 'package:peschef_delivery/res/routes/routes_name.dart';
import 'package:peschef_delivery/view/homeScreen.dart';
import 'package:peschef_delivery/view/loginScreen.dart';
import 'package:peschef_delivery/view/splashScreen.dart';
import 'package:peschef_delivery/view/tabBarView.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.loginScreen,
          page: () => LoginScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.splashScreen,
          page: () => SplashScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.homeScreen,
          page: () => HomeScreen(),
          transitionDuration: Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.tabBarScreen,
          page: () => MyTabView(),
          // transitionDuration: Duration(milliseconds: 250),
          // transition: Transition.leftToRightWithFade,
        ),
      ];
}
