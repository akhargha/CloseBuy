import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item Locator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ItemLocatorPage(),
    );
  }
}

class ItemLocatorPage extends StatefulWidget {
  @override
  _ItemLocatorPageState createState() => _ItemLocatorPageState();
}

class _ItemLocatorPageState extends State<ItemLocatorPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  String dropdownValue = 'Food';
  List<Map<String, String>> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/items.json');
  }

  _loadItems() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String contents = await file.readAsString();
        List<dynamic> json = jsonDecode(contents);
        setState(() {
          items = List<Map<String, String>>.from(json);
        });
      }
    } catch (e) {
      print("Failed to load items: $e");
    }
  }

  _saveItem() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    final newItem = {
      'type': dropdownValue,
      'name': _itemNameController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'price': _priceController.text,
    };

    setState(() {
      items.add(newItem);
    });

    final file = await _localFile;
    await file.writeAsString(jsonEncode(items));

    _itemNameController.clear();
    _locationController.clear();
    _descriptionController.clear();
    _priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Item Locator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField(
                    value: dropdownValue,
                    items: ['Food', 'Item'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                  TextFormField(
                    controller: _itemNameController,
                    decoration: InputDecoration(labelText: 'Item Name'),
                    validator: (value) => value!.isEmpty
                        ? 'Please enter the item name'
                        : null,
                  ),
                  TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(labelText: 'Location'),
                    validator: (value) => value!.isEmpty
                        ? 'Please enter the location'
                        : null,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text("${item['type']} - ${item['name']}"),
                    subtitle: Text("${item['location']} - ${item['description']} - ${item['price']}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
