import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/connectivity.dart';
import 'provider/home_provider.dart';
import 'view/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(builder: (_) => HomeProvider()),
        ChangeNotifierProvider<ConnectivityProvider>(
            builder: (_) => ConnectivityProvider(context)),
      ],
      child: MaterialApp(
        title: 'GoJek',
        theme: ThemeData(
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'Trending'),
      ),
    );
  }
}
