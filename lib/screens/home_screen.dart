import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> fiturList = [
    {'title': 'Kamera', 'route': '/camera'},
    {'title': 'Google Maps', 'route': '/map'},
    {'title': 'Preferences & Menu', 'route': '/prefs'},
    {'title': 'Async Task', 'route': '/async'},
    {'title': 'SMS Autofill', 'route': '/sms_autofill'},
    {'title': 'Grafik Data', 'route': '/chart'},
    {'title': 'Autocomplete & Spinner', 'route': '/autocomplete'},
    {'title': 'Logout / Login', 'route': '/auth'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TugasRanuRamadhan - Menu Utama"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // Reset login & data
              Navigator.pushReplacementNamed(context, '/auth');
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: fiturList.length,
        separatorBuilder: (context, _) => Divider(),
        itemBuilder: (context, index) {
          final fitur = fiturList[index];
          return ListTile(
            title: Text(fitur['title']!, style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, fitur['route']!);
            },
          );
        },
      ),
    );
  }
}
