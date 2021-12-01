import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelperWidgets {
  static Padding rowSpace({double vertical = 3}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical),
    );
  }

  static Widget columnSpace({double horizontal = 3}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
    );
  }

  static Widget applicationBottomNavBar(
      int _selectedIndex, ValueChanged<int> onClickedBottomNavBar) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle),
          label: 'Users',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.videogame_asset),
          label: 'Game Board',
        ),
      ],
      currentIndex: _selectedIndex,
      // selectedItemColor: AppColors.primaryThemeColor,
      onTap: onClickedBottomNavBar,
    );
  }
}
