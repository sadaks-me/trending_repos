// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:go_jek/model/repo.dart';
import 'package:go_jek/provider/home_provider.dart';
import 'package:go_jek/view/widget/list_item.dart';
import 'package:provider/provider.dart';
import 'mock_image_http_client.dart';

void main() {
  // Mock object creation
  Repo repo = new Repo(
      author: "open-deepnude",
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

  // Expected widget within created widgets
  List<String> expectedTexts = [
    repo.author,
    repo.name,
    repo.description,
    repo.language,
    repo.stars.toString(),
    repo.forks.toString()
  ];

  testWidgets('Repo Detail Widget test', (WidgetTester tester) async {
    HttpOverrides.runZoned(() async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HomeProvider>(
                builder: (_) => HomeProvider()),
          ],
          child: MaterialApp(
            home: ListView(
              children: <Widget>[RepoListItem(repo, 0)],
            ),
          ),
        ),
      );

      // Gets the created widgets
      Iterable<Widget> listOfWidgets = tester.allWidgets;
      checkIfTextsCreatedCorrectly(listOfWidgets, expectedTexts);
    }, createHttpClient: createMockImageHttpClient);
  });
}

// Method to check if all texts are created as expected.
void checkIfTextsCreatedCorrectly(
    Iterable<Widget> listOfWidgets, List<String> expectedTexts) {
  var textWidgetPosition = 0;

  for (Widget widget in listOfWidgets) {
    if (widget is Text) {
      expect(widget.data, expectedTexts[textWidgetPosition]);
      textWidgetPosition++;
    }
  }
}
