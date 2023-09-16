import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      body: ListView(
        children: [
          ProfileHeader(),
          SizedBox(height: 45),
          ProfileContent(),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 50),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("John Doe", style: TextStyle(fontSize: 18)),
            SizedBox(height: 4),
            Text("@johndoe"),
          ],
        )
      ],
    );
  }
}

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          ProfileDetail(title: "Name", value: "John Doe"),
          ProfileDetail(title: "Email", value: "john@doe.com"),
          ProfileDetail(title: "Phone", value: "+1 123 456 7890"),
          ProfileDetail(title: "Address", value: "123 Main St, New York NY"),
        ],
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final String title;
  final String value;

  ProfileDetail({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

//class ProfileScreen extends StatelessWidget {
//  const ProfileScreen({super.key});

//@override
//  Widget build(BuildContext context) {
//    return const Center(
//      child: Text('Profile Screen'),
//    );
//  }
//}
