import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_jek/model/repo.dart';
import 'package:async_resource/file_resource.dart';
import 'package:path_provider/path_provider.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    this.initPage();
  }

  int activeTileIndex;
  bool isLoading = false;
  List<Repo> trendingRepoList = new List();

  setLoading() {
    isLoading = true;
    notifyListeners();
  }

  removeLoading() {
    isLoading = false;
    notifyListeners();
  }

  initPage() async {
    setLoading();
    fetchRepos(false);
  }

  setActiveTileIndex(int index){
    activeTileIndex = index;
    notifyListeners();
  }

  Future fetchRepos(bool refreshing) async {
    final path = (await getApplicationDocumentsDirectory()).path;
    final repos = HttpNetworkResource<List<Repo>>(
      url: 'https://github-trending-api.now.sh/repositories',
      parser: (contents) => Repo.fromJsonArray(contents),
      cache: FileResource(File('$path/repos.json')),
      maxAge: Duration(minutes: 2),
      strategy: CacheStrategy.cacheFirst,
    );
    trendingRepoList = await repos.get(forceReload: refreshing);
    removeLoading();
  }
}
