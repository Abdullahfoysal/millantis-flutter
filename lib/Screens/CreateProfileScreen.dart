import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millantis/Constanst/AppImage.dart';
import 'package:millantis/Models/UserTable.dart';
import 'package:millantis/SharedWidget/ButtonLoader.dart';
import 'package:millantis/coreComponent/HttpService.dart';

class CreateProfileScreen extends StatefulWidget {
  final Function() updateListMethod;
  CreateProfileScreen(this.updateListMethod);

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  UserTable user = UserTable();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create User Profile"),
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Name *',
                  ),
                  validator: (value) {
                    return value == null ? "Fill the form" : null;
                  },
                  onChanged: (val) {
                    user.name = val.trim();
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.location_pin),
                    hintText: 'Where do you live?',
                    labelText: 'Address *',
                  ),
                  validator: (value) {
                    return value == null ? "Fill the form" : null;
                  },
                  onChanged: (val) {
                    user.address = val.trim();
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.score),
                    hintText: "What's your rank Name?",
                    labelText: 'Rank *',
                  ),
                  validator: (value) {
                    return value == null ? "Fill the form" : null;
                  },
                  onChanged: (val) {
                    user.rank = val.trim();
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.run_circle),
                    hintText: 'How long do you play?',
                    labelText: 'Play Time *',
                  ),
                  validator: (value) {
                    return value == null ? "Fill the form" : null;
                  },
                  onChanged: (val) {
                    user.playTime = val.trim();
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.verified),
                    hintText: 'Player status?',
                    labelText: 'Type *',
                  ),
                  validator: (value) {
                    return value == null ? "Fill the form" : null;
                  },
                  onChanged: (val) {
                    user.type = val.trim();
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'what is your best score?',
                    labelText: 'Score *',
                  ),
                  validator: (value) {
                    return value == null ? "Fill the form" : null;
                  },
                  onChanged: (val) {
                    user.bestScore = val.trim();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonLoader.button("Create", isLoading, _postMethod),
                /*ElevatedButton(
                  child: Text('Create'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _postMethod();
                    }
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _postMethod() async {
    setState(() {
      isLoading = true;
    });
    String api = "people/create";
    Map<String, dynamic> body = user.toJson();
    bool response = await HttpService().postAsync(api, body).then((value) {
      print(value);
      return value;
    }).catchError((err) {
      print(err);
      setState(() {
        isLoading = false;
      });
    });

    setState(() {
      isLoading = false;
    });

    if (response) {
      ButtonLoader.alertDialogSuccess(context);
    } else {
      ButtonLoader.alertDialogFail(context);
    }
    widget.updateListMethod();

    print(response);
  }
}
