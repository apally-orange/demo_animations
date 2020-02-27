import 'package:animations/animations.dart';
import 'package:demo_animations/data.dart';
import 'package:demo_animations/detail_card.dart';
import 'package:demo_animations/fab_button_animation.dart';
import 'package:demo_animations/repo.dart';
import 'package:flutter/material.dart';
import 'package:demo_animations/add_entry_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Demo Animations'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        crossAxisCount: _isList ? 1 : 3,
                        childAspectRatio: _isList ? 4 : 2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var data = listData[index];
                          return OpenContainer(
                            transitionType: ContainerTransitionType.fadeThrough,
                            openBuilder: (BuildContext context,
                                VoidCallback openContainer) {
                              return DetailCard(data);
                            },
                            transitionDuration: Duration(milliseconds: 1000),
                            closedBuilder:
                                (BuildContext _, VoidCallback openContainer) {
                              return GridTile(
                                child: Card(
                                  color: data.color,
                                  child: Center(
                                    child: Text(data.title),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        addAutomaticKeepAlives: true,
                        addRepaintBoundaries: true,
                        addSemanticIndexes: true,
                        childCount: listData.length,
                      ),
                    ),
                  ],
                );
            }
          },
        ),
        floatingActionButton: FabButtonAnimations(
            AddEntryWidget(), Theme.of(context).colorScheme.primary));
  }
}
