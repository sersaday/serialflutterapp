import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final availablePorts = SerialPort.availablePorts;
  late SerialPort port = SerialPort("/dev/cu.usbserial-0001");

  _sendData() async {
    var value1 = _controller.value.text;

    if (value1.isNotEmpty) {
      value1 = value1.trim();
      List<int> list = value1.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      if (!port.openReadWrite()) {
        print(SerialPort.lastError);
        exit(-1);
      }
      port.write(bytes);
    }
  }

  _deviceList() {
    print(availablePorts);
  }

/*
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      var value1 = _controller.text.trim();
      List<int> list = value1.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      if (!port.openReadWrite()) {
        print(SerialPort.lastError);
        exit(-1);
      }
      port.write(bytes);
    }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Send a message'),
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Deneme',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendData,
        //_deviceList,
        tooltip: 'Increment',
        child: const Icon(Icons.send),
      ),
    );
  }
}
