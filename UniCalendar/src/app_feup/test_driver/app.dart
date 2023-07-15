import '../lib/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();
  
  // Setup default state for tests
  SharedPreferences.setMockInitialValues({
    'favorite_cards': []
  });

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  runApp(MyApp());
}