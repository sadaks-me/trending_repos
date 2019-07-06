import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:go_jek/model/repo.dart';
import 'package:go_jek/provider/connectivity.dart';
import 'package:go_jek/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'widget/list_item.dart';
import 'widget/loading.dart';
import 'widget/no_connection.dart';

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
        centerTitle: true,
        elevation: 0.7,
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
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<ConnectivityProvider>(
              builder: (_) => ConnectivityProvider()),
          ChangeNotifierProvider<HomeProvider>(builder: (_) => HomeProvider()),
        ],
        child: Consumer<HomeProvider>(
            builder: (context, homeProvider, _) => Stack(
                  children: <Widget>[
                    homeProvider.isLoading
                        ? LoadingView()
                        : RefreshIndicator(
                            onRefresh: () => onRefresh(homeProvider),
                            displacement: 20,
                            color: Colors.black,
                            child: ListView.separated(
                              itemCount: homeProvider.trendingRepoList.length,
                              itemBuilder: (context, index) {
                                Repo repo =
                                    homeProvider.trendingRepoList[index];
                                return RepoListItem(repo, index);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Divider(height: 0.5),
                            )),
                    if (homeProvider.repos != null)
                      Consumer<ConnectivityProvider>(
                        builder: (context, connectivity, child) =>
                            FutureBuilder<bool>(
                          initialData: false,
                          future: homeProvider.repos.isExpired,
                          builder: (context, snapshot) {
                            if (snapshot.data) {
                              return (connectivity.connectivityResult !=
                                      ConnectivityResult.none)
                                  ? NoConnectionView()
                                  : SizedBox();
                            } else
                              return SizedBox();
                          },
                        ),
                      ),
                  ],
                )),
      ),
    );
  }

  Future<Null> onRefresh(HomeProvider homeProvider) async {
    homeProvider.setRefreshing(true);
    await homeProvider.fetchRepos(true);
    return homeProvider.completer.future.then((_) {});
  }
}
