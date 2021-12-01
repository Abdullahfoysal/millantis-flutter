import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndivisualPage extends StatefulWidget {
  const IndivisualPage({Key? key}) : super(key: key);

  @override
  _IndivisualPageState createState() => _IndivisualPageState();
}

class _IndivisualPageState extends State<IndivisualPage> {
  late IO.Socket socket;
  int userId = 1;
  String port = "3000";
  String ipAddress = "https://calm-chamber-94669.herokuapp.com";
  String ipAdreessLocal = "http://localhost:3000";
  String message = "";
  String responseMessage = "";
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    connect();
  }

  void connect() {
    socket = IO.io(ipAdreessLocal, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((res) {
      print('connect');
      print(res);
    });
    socket.onDisconnect((handler) {
      print('disconnect from server on client ');
    });
    socket.onConnect((data) {
      print("Connected socket to server");

      socket.on("message", (data) {
        setState(() {
          responseMessage += data + "\n";
        });
      });
      socket.on("initData", (data) {
        print(data);

        setState(() {
          data.forEach((m) {
            print(m['msg']);
            responseMessage += m['msg'] + "\n";
          });
        });
      });
    });
    print(socket.connected);
  }

  void sendMessage(String message) {
    socket.emit("message", message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Millantis socket.io'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: textController,
            ),
            Container(
              child: Expanded(child: Text(responseMessage)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendMessage(
            textController.text,
          );
          textController.clear();
        },
        child: Icon(Icons.send),
      ),
    );
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }
}
