import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millantis/Constanst/AppImage.dart';
import 'package:millantis/Screens/UpdateProfileScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
      },
      child: Card(
        child: Container(
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                radius: 70.0,
                child: ClipOval(
                  child: Image.asset(
                    AppImage.userProfileUrl,
                    fit: BoxFit.cover,
                    width: 120.0,
                    height: 120.0,
                  ),
                ),
              ),
              infoCard("Name: ", "Foysal Ahmed"),
              infoCard("Address: ", "Dhaka,Bangladesh"),
              infoCard("Rank: ", "SuperCell"),
              infoCard("Play Time: ", "54:30"),
              infoCard("Type: ", "Noob"),
              infoCard("Best Score: ", "100"),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCard(String title, String value) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            Text(value),
          ],
        ),
      ),
    );
  }
}
