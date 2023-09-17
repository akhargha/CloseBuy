import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

final Map<String, List<dynamic>> itemsMap = {
  '1': ['Desk Lamp', 'Dorm Appliances', 25.0, 41.7474, -72.6901],
  '2': ['Fridge', 'Kitchen Appliances', 150.0, 41.7480, -72.6890],
  '3': ['T-shirt', 'Clothes', 10.0, 41.7460, -72.6905],
  '4': ['Toy Car', 'Toys and games', 5.0, 41.7485, -72.6880],
  '5': ['Laptop', 'Electronics', 900.0, 41.7479, -72.6910],
  '6': ['Pencil', 'Study supplies', 1.0, 41.7465, -72.6895],
};

final Map<String, Color> categoryColors = {
  'Dorm Appliances': Colors.green,
  'Kitchen Appliances': Colors.blue,
  'Clothes': Colors.red,
  'Toys and games': Colors.yellow,
  'Electronics': Colors.purple,
  'Study supplies': Colors.orange,
};

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ListView with Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();

  var items = <String>[];
  bool isSearching = false;
  bool hasFilterApplied = false;

  final List<String> categories = [
    'Dorm Appliances',
    'Kitchen Appliances',
    'Clothes',
    'Toys and games',
    'Electronics',
    'Study supplies'
  ];
  final Map<String, bool> categorySelected = {};

  @override
  void initState() {
    super.initState();
    items = itemsMap.values.map((item) => item[0] as String).toList();
    categories.forEach((category) => categorySelected[category] = false);
  }
  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        isSearching = false;
        return;
      }
      isSearching = true;
      items = itemsMap.values
          .where((item) => item[0].toLowerCase().contains(query.toLowerCase()))
          .map((item) => item[0] as String)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: isSearching
                  ? ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${items[index]}'),
                  );
                },
              )
                  : _buildFlutterMap(),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: categorySelected[category]!,
                      onSelected: (selected) {
                        setState(() {
                          categorySelected[category] = selected;

                          // Check if all filters are deselected
                          bool anyFilterSelected = categorySelected.values.any((isSelected) => isSelected);

                          // If none of the filters are selected, reset the flag
                          hasFilterApplied = anyFilterSelected;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlutterMap() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(41.7474, -72.6901),
        zoom: 16.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayerOptions(
          markers: itemsMap.entries
              .where((entry) {
            List<dynamic> itemData = entry.value;
            // Filter markers based on selected categories
            if (hasFilterApplied) {
              return categorySelected[itemData[1]]!;
            }
            return true;
          })
              .map((entry) {
            List<dynamic> itemData = entry.value;
            return Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(itemData[3], itemData[4]),
              builder: (ctx) => GestureDetector(
                onTap: () {
                  showDialog(
                    context: ctx,
                    builder: (ctx) => AlertDialog(
                      title: Text(itemData[0]),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Category: ${itemData[1]}'),
                          Text('Price: \$${itemData[2]}'),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: ctx,
                                builder: (ctx) => AlertDialog(
                                  title: Text('Confirm Purchase'),
                                  content: Text(
                                      'Are you sure you want to buy ${itemData[0]} for \$${itemData[2]}?'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop(); // Close the confirmation dialog
                                        Navigator.of(ctx).pop(); // Close the item details dialog
                                        ScaffoldMessenger.of(ctx).showSnackBar(
                                          SnackBar(
                                            content: Text('The seller has been notified'),
                                          ),
                                        );
                                      },
                                      child: Text('Confirm'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop(); // Close the confirmation dialog
                                      },
                                      child: Text('Cancel'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text('Buy'),
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  child: Icon(
                    Icons.location_pin,
                    color: categoryColors[itemData[1]],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
