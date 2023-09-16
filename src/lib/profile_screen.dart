import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        CircleAvatar(radius: 120, backgroundImage: AssetImage('lib/ProfilePicture.png')),
        SizedBox(width: 50),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Chickens for Change", style: TextStyle(fontFamily: 'Raleway', fontSize: 30)),
            SizedBox(height: 10),
            Text("@Bantams"),
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
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          ProfileDetail(title: "Name", value: "Chicken Nuggets"),
          ProfileDetail(title: "Email", value: "chickens.for.change@trincoll.edu"),
          ProfileDetail(title: "Phone", value: "+1 (860) 297 5000"),
          ProfileDetail(title: "Address", value: "300 Summit Street, Hartford"),
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
          Text(title, style: TextStyle(fontFamily:'Raleway' , fontSize: 24)),
          Text(value, style: TextStyle(fontFamily:'Raleway', fontSize: 24)),
        ],
      ),
    );
  }
}
