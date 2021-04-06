import UIKit
import Flutter
import "GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCz9M0GR7Ltfn1TGAr8HdrboxHd2tUYY98")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
