import 'package:flutter/material.dart';
import 'location_model.dart';
import 'package:provider/provider.dart';

class ItemsScreen extends StatefulWidget {
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final itemNameController = TextEditingController();
  final priceController = TextEditingController();
  List<Map<String, dynamic>> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: itemNameController,
                decoration: InputDecoration(labelText: "Item Name"),
              ),
              SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
              ),
              SizedBox(height: 16),
              LocationMap(),
              LocationDropdown(),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  final model = context.read<LocationModel>();
                  setState(() {
                    items.add({
                      "name": itemNameController.text,
                      "price": priceController.text,
                      "location": model.currentOption,
                      "coordinates": model.selectedLocation,
                    });
                    itemNameController.clear();
                    priceController.clear();
                  });
                },
              ),
              ...items.map((item) => ListTile(
                title: Text("${item["name"]} - ${item["price"]}"),
                subtitle: Text(
                    "${item["location"]} - (${item["coordinates"]?.dx}, ${item["coordinates"]?.dy})"),
              )),
            ],
          ),
        ),
      ),
    );
  }
}


class LocationMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<LocationModel>();
    return Stack(
      children: [
        Image.asset('lib/map.png', fit: BoxFit.cover),
        if (model.selectedLocation != null)
          Positioned(
            left: model.selectedLocation!.dx,
            top: model.selectedLocation!.dy,
            child: Icon(Icons.pin_drop, color: Colors.red),
          )
      ],
    );
  }
}

class LocationDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<LocationModel>();
    return DropdownButton<String>(
      value: model.currentOption,
      onChanged: (String? newValue) {
        if (newValue != null) {
          model.setCurrentOption(newValue);
          model.updateSelectedLocation();
        }
      },
      items: model.options.entries
          .map<DropdownMenuItem<String>>((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(entry.key),
        );
      }).toList(),
    );
  }
}
