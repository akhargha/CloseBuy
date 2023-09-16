import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchBar(),
    );
  }
}

class SearchBar extends StatefulWidget
{
  @override
  _SearchBarState createState() => _SearchBarState();
}


class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search)
      ),
    );
  }
}