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
  bool hasDataAndNotExpired;

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
      maxAge: Duration(minutes: 2),
      strategy: CacheStrategy.cacheFirst,
    );
    hasDataAndNotExpired = repos.cache.data != null && !await repos.isExpired;
    fetchRepos(false);
  }

  setActiveTileIndex(int index) {
    activeTileIndex = index;
    notifyListeners();
  }

  Future fetchRepos(bool forceReload) async {
    await repos.get(forceReload: forceReload).then((list) async {
      hasDataAndNotExpired = repos.cache.data != null && !await repos.isExpired;
      if (hasDataAndNotExpired) trendingRepoList = list;
    });
    removeLoading();
    setRefreshing(false);
  }
}
