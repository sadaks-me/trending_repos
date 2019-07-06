import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/connectivity.dart';
import 'provider/home_provider.dart';
import 'view/home_page.dart';
import 'view/widget/no_connection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConnectivityProvider>(
            builder: (_) => ConnectivityProvider()),
        ChangeNotifierProvider<HomeProvider>(builder: (_) => HomeProvider()),
      ],
      child: new Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: <Widget>[
            MaterialApp(
              title: 'GoJek',
              theme: ThemeData(
                primaryColor: Colors.white,
                primarySwatch: Colors.blue,
              ),
              home: HomePage(title: 'Trending'),
            ),
            Consumer<ConnectivityProvider>(
              builder: (context, connectivity, child) =>
              connectivity.connectivityResult == ConnectivityResult.none
                  ? new NoConnectionView()
                  : new SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
