import 'package:flutter/material.dart';

class ButtonLoader {
  static Widget button(String title, bool isLoading, onPressed) {
    return ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            SizedBox(
              width: 10,
            ),
            if (isLoading)
              CircularProgressIndicator(
                color: Colors.white,
              ),
          ],
        ),
        onPressed: onPressed);
  }

  static alertDialogSuccess(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Complete'),
          content: Text('Successful operation'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static alertDialogFail(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fail'),
          content: Text('Failed operation'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
