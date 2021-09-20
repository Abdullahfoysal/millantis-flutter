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
                    _getMethod();
                  },
                  child: Text("Get Request")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {}, child: Text("Post Request")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {}, child: Text("Put Request")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {}, child: Text("Delete Request")),
            ],
          ),
        ),
      ),
    );
  }

  Future _getMethod() async {
    print("called get");
    String api = "";
    var apiResponse = await HttpService().getAsync(api);
    EmployeeModel employeeData = EmployeeModel.fromJson(apiResponse);
    print(employeeData);
  }
}
