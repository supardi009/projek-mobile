import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SMSAutofillScreen extends StatefulWidget {
  @override
  _SMSAutofillScreenState createState() => _SMSAutofillScreenState();
}

class _SMSAutofillScreenState extends State<SMSAutofillScreen>
    with CodeAutoFill {
  String? _code;

  @override
  void initState() {
    super.initState();
    listenForCode();
  }

  @override
  void codeUpdated() {
    setState(() {
      _code = code;
    });
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SMS Autofill')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Masukkan kode OTP:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            PinFieldAutoFill(
              codeLength: 6,
              onCodeChanged: (val) {
                if (val != null && val.length == 6) {
                  setState(() => _code = val);
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              _code != null ? 'Kode Diterima: $_code' : 'Menunggu OTP...',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
