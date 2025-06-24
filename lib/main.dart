import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smart_helper_app/screens/home_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/map_screen.dart';
import 'screens/preferences_menu_screen.dart';
import 'screens/async_task_screen.dart';
import 'screens/sms_autofill_screen.dart';
import 'screens/chart_screen.dart';
import 'screens/autocomplete_spinner_screen.dart';
import 'screens/login_register_screen.dart';

void main() {
  runApp(SmartHelperApp());
}

class SmartHelperApp extends StatelessWidget {
  Future<Widget> _getInitialScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn ? HomeScreen() : LoginRegisterScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHelper App',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/camera': (context) => CameraScreen(),
        '/map': (context) => MapScreen(),
        '/prefs': (context) => PreferencesMenuScreen(),
        '/async': (context) => AsyncTaskScreen(),
        '/sms_autofill': (context) => SMSAutofillScreen(),
        '/chart': (context) => ChartScreen(),
        '/autocomplete': (context) => AutocompleteSpinnerScreen(),
        '/auth': (context) => LoginRegisterScreen(),
        '/home': (context) => HomeScreen(),
      },
      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!;
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
