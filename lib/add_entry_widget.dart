import 'package:demo_animations/data.dart';
import 'package:demo_animations/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class AddEntryWidget extends StatefulWidget {
  const AddEntryWidget({Key key}) : super(key: key);

  @override
  _AddEntryWidgetState createState() => _AddEntryWidgetState();
}

class _AddEntryWidgetState extends State<AddEntryWidget> {
  final _formKey = GlobalKey<FormState>();
  final _data = Data();

  @override
  void initState() {
    _data.color = Colors.blue;
    super.initState();
  }

  void _openDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text("Choose color"),
          content: MaterialColorPicker(
            selectedColor: _data.color,
            allowShades: false,
            onColorChange: (color) => setState(() => _data.color = color),
            onMainColorChange: (color) => setState(() => _data.color = color),
          ),
          actions: [
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Entry"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your title.';
                  }
                },
                onSaved: (val) => setState(() => _data.title = val),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your description.';
                  }
                },
                onSaved: (val) => setState(() => _data.description = val),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("Color:"),
                    GestureDetector(
                      onTap: () => _openDialog(),
                      child: CircleAvatar(
                        backgroundColor: _data.color,
                        radius: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      Repo().addData(_data);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add')),
            ],
          ),
        ),
      ),
    );
  }
}
