import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_jek/model/repo.dart';
import 'package:async_resource/file_resource.dart';
import 'package:path_provider/path_provider.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    this.initPage();
  }

  HttpNetworkResource<List<Repo>> repos;
  List<Repo> trendingRepoList = new List();
  bool isLoading = false;
  Completer completer;
  int activeTileIndex;
  Duration maxAge = Duration(minutes: 2);

  setLoading() {
    isLoading = true;
    notifyListeners();
  }

  removeLoading() {
    isLoading = false;
    notifyListeners();
  }

  setRefreshing(bool isRefreshing) {
    if (isRefreshing) {
      completer = new Completer<Null>();
    } else {
      if (completer != null) {
        completer.complete(null);
      }
    }
    notifyListeners();
  }

  initPage() async {
    setLoading();
    final path = (await getApplicationDocumentsDirectory()).path;
    repos = HttpNetworkResource<List<Repo>>(
      url: 'https://github-trending-api.now.sh/repositories',
      parser: (contents) => Repo.fromJsonArray(contents),
      cache: FileResource(File('$path/repos.json')),
      maxAge: maxAge,
      strategy: CacheStrategy.cacheFirst,
    );
    fetchRepos(false);
  }

  setActiveTileIndex(int index) {
    activeTileIndex = index;
    notifyListeners();
  }

  Future fetchRepos(bool forceReload) async {
    await repos.get(forceReload: forceReload).then((list) async {
      if (!await repos.isExpired) trendingRepoList = list;
    });
    if (repos.cache.data != null) print('HAS DATA');
    removeLoading();
    setRefreshing(false);
  }
}
