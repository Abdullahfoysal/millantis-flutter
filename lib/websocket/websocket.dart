import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketDemo extends StatefulWidget {
  WebsocketDemo({Key? key}) : super(key: key);

  final WebSocketChannel channel =
      IOWebSocketChannel.connect('wss://echo.websocket.org');

  @override
  _WebsocketDemoState createState() => _WebsocketDemoState();
}

class _WebsocketDemoState extends State<WebsocketDemo> {
  final inputController = TextEditingController();
  List<String> messageList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Millantis websocket'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: inputController,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (inputController.text.isNotEmpty) {
                          print(inputController.text);
                          widget.channel.sink.add(inputController.text);
                          inputController.text = '';
                        }
                      },
                      child: Text('send'),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  stream: widget.channel.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      messageList.add(snapshot.data.toString());
                    }
                    return getMessageList();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView getMessageList() {
    List<Widget> listWidget = [];

    for (String message in messageList) {
      listWidget.add(
        ListTile(
          title: Container(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                message,
                style: TextStyle(fontSize: 22),
              ),
            ),
            color: Colors.teal[50],
            height: 50,
          ),
        ),
      );
    }
    return ListView(
      children: listWidget,
    );
  }

  @override
  void dispose() {
    inputController.dispose();
    widget.channel.sink.close();
    super.dispose();
  }
}
