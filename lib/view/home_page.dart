import 'package:flutter/material.dart';
import 'package:go_jek/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'widget/loading.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: Consumer<HomeProvider>(
          builder: (context, homeProvider, _) =>
          homeProvider.isLoading ? LoadingView() : SizedBox()),
    );
  }
}
