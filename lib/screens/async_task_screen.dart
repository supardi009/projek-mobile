import 'package:flutter/material.dart';

class AsyncTaskScreen extends StatefulWidget {
  @override
  _AsyncTaskScreenState createState() => _AsyncTaskScreenState();
}

class _AsyncTaskScreenState extends State<AsyncTaskScreen> {
  bool _isLoading = false;
  String _result = '';

  Future<void> _startAsyncTask() async {
    setState(() {
      _isLoading = true;
      _result = '';
    });

    // Simulasi proses berat selama 3 detik
    await Future.delayed(Duration(seconds: 3), () {
      _result = 'Data berhasil diambil!';
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Async Task')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton.icon(
                    onPressed: _startAsyncTask,
                    icon: Icon(Icons.download),
                    label: Text('Mulai Async Task'),
                  ),
              SizedBox(height: 20),
              Text(
                _result,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
