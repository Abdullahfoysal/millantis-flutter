import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millantis/Models/EmployeeModel.dart';
import 'package:millantis/Screens/ProfileScreen.dart';
import 'package:millantis/coreComponent/HttpService.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<EmployeeModel> employeeList = [];

  @override
  void initState() {
    _getMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All User List"),
      ),
      body: getUserListWidget,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget get getUserListWidget {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          for (int i = 0; i < 5; i++) getProfileScreen(),
        ],
      ),
    );
  }

  Widget getProfileScreen() {
    return Stack(
      children: [
        ProfileScreen(),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove_circle_outline),
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Future _getMethod() async {
    print("called get");
    String api = "people";

    employeeList = await HttpService().getAsync(api).then((value) {
      return EmployeeModel().fromJsonList(value);
    }).catchError((err) {
      print(err);
    });

    employeeList.forEach((element) {
      print(element.name);
    });
  }

  Future _postMethod() async {
    String api = "people/create";
    Map<String, dynamic> body = {
      "name": "Hasan",
      "age": 20,
      "school": "Sristy school",
      "college": "BN college",
    };
    var response = await HttpService().postAsync(api, body).then((value) {
      print(value);
      return value;
    }).catchError((err) {
      print(err);
    });

    print(response);
  }
}
