import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:package_channel/package_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String packageChannel = "Unknown pack age";

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getPackageChannel();
  }

  Future<void> getPackageChannel() async {

    String packageC;

    try {
      packageC = await PackageChannel.getChannel;
    } on PlatformException {
      packageC = 'Failed to getChannel.';
    }

    if (!mounted) return;

    if (packageC != null) {
      setState(() {
        packageChannel = packageC;
      });
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await PackageChannel.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              Padding(padding: EdgeInsets.only(top: 30)),
              Text('Running on: $packageChannel\n'),
            ],
          ),
        ),
      ),
    );
  }
}
