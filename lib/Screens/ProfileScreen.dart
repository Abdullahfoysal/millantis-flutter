import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millantis/Constanst/AppImage.dart';
import 'package:millantis/Models/UserTable.dart';
import 'package:millantis/Screens/UpdateProfileScreen.dart';

class ProfileScreen extends StatelessWidget {
  final UserTable user;
  final Function() updateListMethod;

  ProfileScreen(this.user, this.updateListMethod);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UpdateProfileScreen(user, updateListMethod)));
      },
      child: Card(
        child: Container(
          width: 250,
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
              infoCard("ID: ", user.id.toString()),
              infoCard("Name: ", user.name.toString()),
              infoCard("Address: ", user.address.toString()),
              infoCard("Rank: ", user.rank.toString()),
              infoCard("Play Time: ", user.playTime.toString()),
              infoCard("Type: ", user.type.toString()),
              infoCard("Best Score: ", user.bestScore.toString()),
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
