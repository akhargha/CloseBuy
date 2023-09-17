import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'items_screen.dart';
import 'profile_screen.dart';
import 'location_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(BottomNavBarApp());

class BottomNavBarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationModel(),
      child: MaterialApp(
        home: _BottomNavBar(),
      ),
    );
  }
}

class _BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<_BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    ItemsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CloseBuy'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
