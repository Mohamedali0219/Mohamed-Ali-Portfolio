import 'splash_service_stub.dart'
    if (dart.library.html) 'splash_service_web.dart'
    if (dart.library.js_interop) 'splash_service_web.dart';

class SplashService {
  static void hide() {
    hideSplash();
  }
}
