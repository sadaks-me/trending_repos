import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:go_jek/model/repo.dart';

void main() {
  List<Repo> repoList;
  String jsonText = '{' +
      '"author": "open-deepnude",' +
      '"name": "open-deepnude",' +
      '"avatar": "https://github.com/open-deepnude.png",' +
      '"url": "https://github.com/open-deepnude/open-deepnude",' +
      '"description": "Open source reverse-engineered clone of DeepNude",' +
      '"language": "Python",' +
      '"languageColor": "#3572A5",' +
      '"stars": 915,' +
      '"forks": 454,' +
      '"currentPeriodStars": 109,' +
      '"builtBy": []' +
      '}';

  setUp(() {
    repoList = new List();
  });

  group("repo list creation test", () {
    test('create repo item', () {
      repoList.add(Repo.fromJson(json.decode(jsonText)));
      List results = repoList;
      expect(results.length, 1);
      Repo repo = repoList.first;
      expect(repo, isNot(null));
      expect(repo.name, 'open-deepnude');
    });

    test('create repo list with json string', () {
      repoList.add(Repo.fromJson(json.decode(jsonText)));
      List<Repo> list = repoList;
      expect(list.length, 1);
    });
  });
}
