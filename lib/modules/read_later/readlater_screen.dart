import 'package:flutter/material.dart';

class ReadLaterScreen extends StatelessWidget {
  const ReadLaterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Later'),
      ),
      body:Center(child: Text('Read later Body')),
    );
  }
}
