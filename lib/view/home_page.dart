import 'package:flutter/material.dart';
import 'package:go_jek/model/repo.dart';
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
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0.5,
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
          builder: (context, homeProvider, _) => homeProvider.isLoading
              ? LoadingView()
              : ListView.builder(
                  itemCount: homeProvider.trendingRepoList.length,
                  itemBuilder: (context, index) {
                    Repo repo = homeProvider.trendingRepoList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        minRadius: 15,
                        maxRadius: 15,
                        backgroundColor: Colors.grey.shade50,
                        backgroundImage: NetworkImage(repo.avatar),
                      ),
                      title: Text(
                        repo.author,
                        style: textTheme.caption,
                      ),
                      subtitle: Text(
                        repo.description,
                        maxLines: 2,
                        style: textTheme.title.copyWith(fontSize: 16),
                      ),
                    );
                  })),
    );
  }
}
