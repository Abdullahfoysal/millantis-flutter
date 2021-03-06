import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:millantis/Constanst/AppImage.dart';
import 'package:millantis/Models/UserTable.dart';
import 'package:millantis/SharedWidget/ButtonLoader.dart';
import 'package:millantis/coreComponent/HttpService.dart';

class UpdateProfileScreen extends StatefulWidget {
  final UserTable user;
  final Function() updateListMethod;

  UpdateProfileScreen(this.user, this.updateListMethod);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState(user);
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserTable user;
  bool isLoading = false;

  _UpdateProfileScreenState(this.user);

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
                  initialValue: user.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  initialValue: user.address,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  initialValue: user.rank,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  initialValue: user.playTime,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  initialValue: user.type,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  initialValue: user.bestScore,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                ButtonLoader.button("Update", isLoading, _postUpdateMethod),
                /* ElevatedButton(
                  child: Text('Update'),
                  onPressed: ()async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading =true;
                      });
                      _postUpdateMethod();

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

  void _postUpdateMethod() async {
    setState(() {
      isLoading = true;
    });
    String api = "people/update";
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
