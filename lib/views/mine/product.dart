import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("我的产品"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: Center(
            child: Text('我的产品'),
          ),
        ),
      ),
    );
  }
}