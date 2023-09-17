import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math'; // For random number generation
import 'home_screen.dart';


class ItemsScreen extends StatefulWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _productName;
  late String _category;
  double? _price;
  bool _showMap = false;

  final List<String> _categories = [
    'Dorm Appliances',
    'Kitchen Appliances',
    'Clothes',
    'Toys and games',
    'Electronics',
    'Study supplies',
  ];

  @override
  Widget build(BuildContext context) {
    if (!_showMap) {
      return Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name of product'),
                  onSaved: (value) => _productName = value!,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Category'),
                  items: _categories
                      .map((category) => DropdownMenuItem(
                    child: Text(category),
                    value: category,
                  ))
                      .toList(),
                  onChanged: (value) => _category = value as String,
                  validator: (value) => value == null ? 'Required' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSaved: (value) => _price = double.tryParse(value!),
                  validator: (value) {
                    if (value!.isEmpty) return 'Required';
                    if (double.tryParse(value) == null) return 'Enter a valid number';
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() => _showMap = true);
                    }
                  },
                  child: Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text('Pick Location')),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(41.7474, -72.6901),
            zoom: 16.0,
            onTap: (position) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Confirm Location'),
                  content: Text('Do you want to pick this location for your product?'),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: Text('Confirm'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        _addItemToMap(position);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Item has been successfully added')),
                        );

                      },
                    ),
                  ],
                ),
              );
            },
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
          ],
        ),
      );
    }
  }
  String _generateItemId() {
    // Generates a random 6 digit number
    var random = Random();
    var id = '';
    for (int i = 0; i < 6; i++) {
      id += random.nextInt(10).toString();
    }
    return id;
  }

  void _addItemToMap(LatLng position) {
    final itemId = _generateItemId();
    final itemData = [_productName, _category, _price, position.latitude, position.longitude];
    print(itemData);
    itemsMap[itemId] = itemData;

    // Now reset the screen to go back to the original form
    setState(() {
      _showMap = false;
    });
  }

}
