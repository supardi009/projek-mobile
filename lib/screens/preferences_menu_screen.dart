import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesMenuScreen extends StatefulWidget {
  @override
  _PreferencesMenuScreenState createState() => _PreferencesMenuScreenState();
}

class _PreferencesMenuScreenState extends State<PreferencesMenuScreen> {
  final TextEditingController _nameController = TextEditingController();
  List<String> _submittedNames = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNames();
  }

  Future<void> _loadNames() async {
    final prefs = await SharedPreferences.getInstance();
    final names = prefs.getStringList('submitted_names') ?? [];
    await Future.delayed(Duration(milliseconds: 500)); // efek loading
    setState(() {
      _submittedNames = names;
      _isLoading = false;
    });
  }

  Future<void> _saveName() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      _showSnackBar('Nama tidak boleh kosong!');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _submittedNames.insert(0, name);
    });
    await prefs.setStringList('submitted_names', _submittedNames);
    _nameController.clear();
    _showSnackBar('Nama "$name" berhasil disimpan!');
  }

  Future<void> _resetPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('submitted_names');
    setState(() {
      _submittedNames.clear();
      _nameController.clear();
    });
    _showSnackBar('Semua data direset!');
  }

  void _handleMenu(String value) {
    switch (value) {
      case 'save':
        _saveName();
        break;
      case 'clear':
        _nameController.clear();
        break;
      case 'reset':
        _resetPreferences();
        break;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  Widget _buildNameList() {
    if (_submittedNames.isEmpty) {
      return Center(
        child: Text(
          'Belum ada nama disimpan.',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _submittedNames.length,
      itemBuilder: (context, index) {
        final name = _submittedNames[index];
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(name),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Nama Disimpan'),
        backgroundColor: Colors.indigo,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: _handleMenu,
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: 'save', child: Text('Simpan Nama')),
                  PopupMenuItem(value: 'clear', child: Text('Hapus Input')),
                  PopupMenuItem(value: 'reset', child: Text('Reset Semua')),
                ],
          ),
        ],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Masukkan Nama Anda',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: _saveName,
                              icon: Icon(Icons.save),
                              label: Text('Simpan Nama'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Riwayat Submit:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildNameList(),
                  ],
                ),
              ),
    );
  }
}
