import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millantis/SharedWidget/HelperWidgets.dart';
import 'package:millantis/gameUI/gameBoard.dart';

import 'RequestScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  void onClickedBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Game CRUD APPLICATION"),
      ),
      body: _body(),
      bottomNavigationBar: HelperWidgets.applicationBottomNavBar(
          _selectedIndex, onClickedBottomNavBar),
    );
  }

  Widget _body() {
    switch (_selectedIndex) {
      case 0:
        return RequestScreen();
      default:
        return GameBoard();
    }
  }
}
