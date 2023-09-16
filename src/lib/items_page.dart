// blank_page.dart
import 'package:flutter/material.dart';

class items_page extends StatelessWidget {
  const items_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Items Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Go Back to Main Page'),
        ),
      ),
    );
  }
}
