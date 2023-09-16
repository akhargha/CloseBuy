import 'package:flutter/material.dart';
import 'item_locator_page.dart';

void main() => runApp(MyApp());

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

