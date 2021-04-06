# Google Maps In Flutter

Colocando o google maps em um aplicativo Flutter.

## Começando 

Primeiramente devemos consegui um chave API para usar aqui. Embora tenha este [tutorial para Android](https://developers.google.com/maps/documentation/android-sdk/get-api-key)
este para [ios](https://developers.google.com/maps/documentation/ios-sdk/get-api-key). Devemos nos atentar em ativar os 
devidos recurso nesse que estão na [biblioteca](https://console.cloud.google.com/apis/library).

- Maps SDK for Android;
- Maps SDK for iOs;
- entre outros.

E na hora de configurar a API devemos selecionar estes recursos para restringir a API.

<img src="img/android-api.jpg">

Android API, de inicio a unica opção será a de habilitar este recurso.

<img src="img/restrict-api.jpg">

Então selecionamos os recurso para que a nossa API fique restrita.

## Nota

O [codelabs](https://codelabs.developers.google.com/codelabs/google-maps-in-flutter/#0) tem alguma diferenças da quais podem 
causar alguns erros começando pelo **AppDelegate.swift** do qual lá é **AppDelegate.m**. Ao invez de usar este codigo:
```
#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
// Add the following import.
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Add the following line, with your API key
  [GMSServices provideAPIKey: @"YOUR-API-KEY"];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
```
Use este aqui:
```
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
```
E em **lib/main.dart** na reta final, ao invel de usar
```
import 'src/locations.dart' as locations;
```
Simplesmente apague o `src/`, ficando `import 'locations.dart' as locations;`



