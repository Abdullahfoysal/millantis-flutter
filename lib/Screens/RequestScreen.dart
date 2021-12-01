import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millantis/Models/EmployeeModel.dart';
import 'package:millantis/coreComponent/HttpService.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await _getMethod();
                  },
                  child: Text("Get Request")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await _postMethod();
                  },
                  child: Text("Post Request")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {}, child: Text("Put Request")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await _deleteMethod();
                  },
                  child: Text("Delete Request")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await _getSingleUserMethod();
                  },
                  child: Text("get single User")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await _postUpdateMethod();
                  },
                  child: Text("update User with age")),
            ],
          ),
        ),
      ),
    );
  }

  Future _getMethod() async {
    print("called get");
    String api = "people";
    List<EmployeeModel> employeeList = [];
    employeeList = await HttpService().getAsync(api).then((value) {
      return EmployeeModel().fromJsonList(value);
    }).catchError((err) {
      print(err);
    });

    employeeList.forEach((element) {
      print(element.name);
    });
  }

  Future _getSingleUserMethod() async {
    String api = "people/user/20";
    List<EmployeeModel> employeeList = [];
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

  Future _postUpdateMethod() async {
    String api = "people/update";
    Map<String, dynamic> body = {
      "name": "foysal",
      "age": 25,
      "school": "Sristy Central schooldada",
      "college": "BN collegdaade",
    };

    var response = await HttpService().postAsync(api, body).then((value) {
      print(value);
      return value;
    }).catchError((err) {
      print(err);
    });

    print(response);
  }

  Future _deleteMethod() async {
    String api = "people/user";
    var response = await HttpService().deleteAsync(api, "20").then((value) {
      print(value);
      return value;
    }).catchError((err) {
      print(err);
    });

    print(response);
  }
}
