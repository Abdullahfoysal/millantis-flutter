import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millantis/Constanst/AppImage.dart';
import 'package:millantis/Models/UserTable.dart';
import 'package:millantis/coreComponent/HttpService.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  UserTable user = UserTable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User Profile"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
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
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Name *',
                  ),
                  validator: (value) {
                    // validation logic
                  },
                  onChanged: (val) {
                    user.name = val.trim();
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.location_pin),
                    hintText: 'Where do you live?',
                    labelText: 'Address *',
                  ),
                  validator: (value) {
                    // validation logic
                  },
                  onChanged: (val) {
                    user.address = val.trim();
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.score),
                    hintText: "What's your rank Name?",
                    labelText: 'Rank *',
                  ),
                  validator: (value) {
                    // validation logic
                  },
                  onChanged: (val) {
                    user.rank = val.trim();
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.run_circle),
                    hintText: 'How long do you play?',
                    labelText: 'Play Time *',
                  ),
                  validator: (value) {
                    // validation logic
                  },
                  onChanged: (val) {
                    user.playTime = val.trim();
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.verified),
                    hintText: 'Player status?',
                    labelText: 'Type *',
                  ),
                  validator: (value) {
                    // validation logic
                  },
                  onChanged: (val) {
                    user.type = val.trim();
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'what is your best score?',
                    labelText: 'Score *',
                  ),
                  validator: (value) {
                    // validation logic
                  },
                  onChanged: (val) {
                    user.bestScore = val.trim();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text('Update'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // text in form is valid
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}
