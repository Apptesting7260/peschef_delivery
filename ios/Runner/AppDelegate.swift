import UIKit
import Flutter
//import Firebase
import GoogleMaps
//import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//FirebaseApp.configure()

//       FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
//         GeneratedPluginRegistrant.register(with: registry)}

      GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyBiHHfJBmHiAg5dZTz7sS7qgg45_gQTjh8")

    //  if #available(iOS 10.0, *) {
    //               UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    //            }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
