import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_jek/model/repo.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    this.initPage();
  }

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

  initPage() async {}

  Future fetchRepos() async {

  }
}
