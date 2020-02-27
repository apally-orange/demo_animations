import 'package:animations/animations.dart';
import 'package:demo_animations/add_entry_widget.dart';
import 'package:demo_animations/data.dart';
import 'package:demo_animations/detail_card.dart';
import 'package:demo_animations/fab_button_animation.dart';
import 'package:demo_animations/repo.dart';
import 'package:demo_animations/setting_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isList = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(_isList ? Icons.view_module : Icons.view_list),
              onPressed: () {
                setState(() {
                  _isList = !_isList;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            )
          ],
        ),
        body: StreamBuilder(
          stream: Repo().list,
          builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                var listData = snapshot.data;
                List<Widget> pageList = <Widget>[
                  ListPage(listData),
                  GridPage(listData),
                ];
                return PageTransitionSwitcher(
                  duration: Duration(milliseconds: 800),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return FadeThroughTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      child: child,
                    );
                  },
                  child: pageList[_isList ? 0 : 1],
                );
            }
          },
        ),
        floatingActionButton: FabButtonAnimations(
            AddEntryWidget(), Theme.of(context).colorScheme.primary));
  }
}

class ListPage extends StatelessWidget {
  final List<Data> list;

  ListPage(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final data = list[index];
        return OpenContainer(
            transitionType: ContainerTransitionType.fade,
            openBuilder: (BuildContext context, VoidCallback openContainer) {
              return DetailCard(data);
            },
            transitionDuration: Duration(milliseconds: 1000),
            closedBuilder: (BuildContext _, VoidCallback openContainer) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: data.color,
                  radius: 25.0,
                ),
                title: Text(data.title),
                subtitle: Text(data.description),
              );
            });
      },
      itemCount: list.length,
    );
  }
}

class GridPage extends StatelessWidget {
  final List<Data> list;

  GridPage(this.list);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: list.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        final data = list[index];
        return OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            openBuilder: (BuildContext context, VoidCallback openContainer) {
              return DetailCard(data);
            },
            transitionDuration: Duration(milliseconds: 1000),
            closedBuilder: (BuildContext _, VoidCallback openContainer) {
              return GridTile(
                child: Card(
                  color: data.color,
                  child: Center(
                    child: Text(data.title),
                  ),
                ),
              );
            });
      },
    );
  }
}
