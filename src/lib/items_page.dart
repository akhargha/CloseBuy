import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Items Page")),
      body: Stack(
        children: [
          // Map integration starts here
          FlutterMap(
            options: MapOptions(
              center: LatLng(51.5, -0.09), // Default location: London
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(51.5, -0.09),
                    builder: (ctx) => Icon(Icons.location_on, color: Colors.red,),
                  ),
                ],
              ),
            ],
          ),
          // Map integration ends here

          // This is the button to return to the main page
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Go Back to Main Page'),
            ),
          ),
        ],
      ),
    );
  }
}
