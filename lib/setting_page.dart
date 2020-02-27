import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _index0 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                _index0 ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
            onPressed: () {
              setState(() {
                _index0 = !_index0;
              });
            },
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        reverse: !_index0,
        duration: Duration(milliseconds: 800),
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
            child: child,
          );
        },
        child: _index0 ? _Page0() : _Page1(),
      ),
    );
  }
}

class _Page0 extends StatelessWidget {
  const _Page0();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ListTile(title: Text('Page 0')),
          CheckboxListTile(
            value: true,
            title: Text("This is a CheckBoxPreference 1"),
            onChanged: (value) {},
          ),
          CheckboxListTile(
            value: true,
            title: Text("This is a CheckBoxPreference 2"),
            onChanged: (value) {},
          ),
          CheckboxListTile(
            value: true,
            title: Text("This is a CheckBoxPreference 3"),
            onChanged: (value) {},
          ),
          SwitchListTile(
            value: false,
            title: Text("This is a SwitchPreference"),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}

class _Page1 extends StatelessWidget {
  const _Page1();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(title: Text('Page 1')),
          CheckboxListTile(
            value: true,
            title: Text("This is a CheckBoxPreference"),
            onChanged: (value) {},
          ),
          SwitchListTile(
            value: false,
            title: Text("This is a SwitchPreference 1"),
            onChanged: (value) {},
          ),
          SwitchListTile(
            value: false,
            title: Text("This is a SwitchPreference 2"),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
