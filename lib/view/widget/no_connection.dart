import 'package:flutter/material.dart';
import 'package:go_jek/provider/connectivity.dart';
import 'package:go_jek/provider/home_provider.dart';
import 'package:provider/provider.dart';

class NoConnectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith();
    final TextTheme textTheme = theme.textTheme;

    return Container(
      color: Colors.grey.shade100,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/no_connection.png',
                      fit: BoxFit.contain,
                      height: 350,
                      width: 250,
                    ),
                    Text(
                      'Something went wrong..',
                      style: textTheme.title,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'An alien is probably blocking your signal.',
                      style: textTheme.body1
                          .copyWith(color: textTheme.caption.color),
                    ),
                  ],
                ),
              ),
            )),
            Consumer<ConnectivityProvider>(
              builder: (context, connectivity, child) => Padding(
                padding: const EdgeInsets.all(15),
                child: RaisedButton(
                  onPressed: () {
                    if (connectivity.hasConnection) {
                      HomeProvider homeProvider =
                          Provider.of<HomeProvider>(context);
                      homeProvider.setLoading();
                      homeProvider.fetchRepos(true);
                    }
                  },
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(color: Colors.green)),
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      'RETRY',
                      style: textTheme.button.copyWith(color: Colors.green),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
