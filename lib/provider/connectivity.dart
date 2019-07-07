import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_jek/provider/home_provider.dart';
import 'package:provider/provider.dart';

printIfDebug(data) {
  if (!kReleaseMode) print(data);
}

class ConnectivityProvider with ChangeNotifier {
  StreamController<ConnectivityResult> connectivityController = new StreamController<ConnectivityResult>.broadcast();
  Stream<ConnectivityResult> connectionStream;
  ConnectivityResult connectivityResult;
  bool hasConnection;
  BuildContext context;

  ConnectivityProvider(BuildContext context) {
    try {
      this.context = context;
      Connectivity().checkConnectivity().then((result) {
        updateConnectionStatus(result);
      });
      addConnectionListener();
      addConnectionStream();
    } on PlatformException catch (e) {
      printIfDebug(e.toString());
    }
  }

  addConnectionStream() async {
    printIfDebug('Added Connection Stream');
    await connectivityController
        .addStream(Connectivity().onConnectivityChanged);
    notifyListeners();
  }

  addConnectionListener() {
    printIfDebug('Added Connection Listener');
    connectivityController.stream.listen((result) {
      updateConnectionStatus(result);
    });
    notifyListeners();
  }

  updateConnectionStatus(ConnectivityResult newResult) {
    connectivityResult = newResult;
    hasConnection = connectivityResult != ConnectivityResult.none;
    if (hasConnection) {
      Consumer<HomeProvider>(builder: (context, homeProvider, _) {
        homeProvider.fetchRepos(true);
        return SizedBox();
      });
    }
    notifyListeners();
    printIfDebug('Connectivity Status:\t' + connectivityResult.toString());
  }
}
