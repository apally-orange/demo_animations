import 'dart:async';

import 'package:demo_animations/data.dart';
import 'package:flutter/material.dart';

class Repo {
  static final Repo _instance = Repo._internal();

  factory Repo() {
    return _instance;
  }

  Repo._internal() {
    s.add(_listData);
  }

  StreamController s = new StreamController<List<Data>>();

  List<Data> _listData = [
    Data(title: "Orange", description: "Orange color", color: Colors.orange),
    Data(title: "Blue", description: "Blue color", color: Colors.blue),
    Data(title: "Yellow", description: "Yellow color", color: Colors.yellow),
    Data(title: "Green", description: "Green color", color: Colors.green),
    Data(title: "Grey", description: "Grey color", color: Colors.grey),
  ];

  Stream<List<Data>> get list => s.stream;

  void addData(Data data) {
    _listData.add(data);
    s.sink.add(_listData);
  }
}
