import 'package:flutter/material.dart';

class AutocompleteSpinnerScreen extends StatefulWidget {
  @override
  _AutocompleteSpinnerScreenState createState() => _AutocompleteSpinnerScreenState();
}

class _AutocompleteSpinnerScreenState extends State<AutocompleteSpinnerScreen> {
  final List<String> _kotaList = [
    'Jakarta', 'Surabaya', 'Bandung', 'Yogyakarta', 'Semarang', 'Medan'
  ];
  final List<String> _kategoriList = ['Pendidikan', 'Kesehatan', 'Teknologi', 'Lainnya'];

  String? _selectedKota;
  String? _selectedKategori;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Autocomplete & Spinner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') return const Iterable<String>.empty();
                return _kotaList.where((String option) {
                  return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                setState(() {
                  _selectedKota = selection;
                });
              },
              fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Kota',
                    border: OutlineInputBorder(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              value: _selectedKategori,
              items: _kategoriList.map((kategori) {
                return DropdownMenuItem(value: kategori, child: Text(kategori));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedKategori = value;
                });
              },
            ),
            SizedBox(height: 30),
            Text(
              'Kota: ${_selectedKota ?? "-"}\nKategori: ${_selectedKategori ?? "-"}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
