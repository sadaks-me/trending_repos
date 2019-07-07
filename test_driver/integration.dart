import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:go_jek/model/repo.dart';
import 'package:go_jek/provider/home_provider.dart';
import 'package:go_jek/view/widget/list_item.dart' as app;
import 'package:provider/provider.dart';

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();
  Repo repo = new Repo(
      author: "open-deepnude-h",
      name: "open-deepnude",
      avatar: "https://github.com/open-deepnude.png",
      url: "https://github.com/open-deepnude/open-deepnude",
      description: "Open source reverse-engineered clone of DeepNude",
      language: "Python",
      languageColor: "#3572A5",
      stars: 915,
      forks: 454,
      currentPeriodStars: 109,
      builtBy: []);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(builder: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        home: ListView(
          children: <Widget>[app.RepoListItem(repo, 0)],
        ),
      ),
    ),
  );
}
