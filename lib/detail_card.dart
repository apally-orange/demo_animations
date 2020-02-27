import 'package:demo_animations/data.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final Data data;
  const DetailCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        backgroundColor: data.color,
      ),
      body: Center(
        child: Text(data.description),
      ),
    );
  }
}
