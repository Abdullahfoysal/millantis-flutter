import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millantis/Models/UserTable.dart';
import 'package:millantis/Screens/CreateProfileScreen.dart';
import 'package:millantis/Screens/ProfileScreen.dart';
import 'package:millantis/SharedWidget/ButtonLoader.dart';
import 'package:millantis/coreComponent/HttpService.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserTable> userList = [];

  void updateListMethod() {
    _getMethod();
  }

  @override
  void initState() {
    _getMethod();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant UserList oldWidget) {
    _getMethod();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "All User List",
          style: TextStyle(color: Colors.black26),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _getMethod();
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.blue,
              ))
        ],
      ),
      body: getUserListWidget,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateProfileScreen(updateListMethod)));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget get getUserListWidget {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          for (int i = 0; i < userList.length; i++)
            getProfileScreen(userList[i]),
        ],
      ),
    );
  }

  Widget getProfileScreen(UserTable user) {
    return Stack(
      children: [
        ProfileScreen(user, updateListMethod),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () async {
              await _deleteMethod(user.id!);
            },
            icon: Icon(Icons.remove_circle_outline),
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Future _deleteMethod(int id) async {
    String api = "people/user";
    bool response =
        await HttpService().deleteAsync(api, id.toString()).then((value) {
      print(value);
      return value;
    }).catchError((err) {
      print(err);
    });

    if (response) {
      ButtonLoader.alertDialogSuccess(context);
    } else {
      ButtonLoader.alertDialogFail(context);
    }
    if (response) {
      setState(() {
        userList.removeWhere((element) => element.id == id);
      });
    }

    print(response);
  }

  Future _getMethod() async {
    print("called get");
    String api = "people";

    List<UserTable> userList2 = [];
    userList2 = await HttpService().getAsync(api).then((value) {
      return UserTable().fromJsonList(value);
    }).catchError((err) {
      print(err);
    });

    setState(() {
      userList = userList2;
    });
  }
}
