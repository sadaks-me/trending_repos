import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

printIfDebug(data) {
  if (!kReleaseMode) print(data);
}

class ConnectivityProvider with ChangeNotifier {
  StreamController<ConnectivityResult> connectivityController = new StreamController<ConnectivityResult>.broadcast();
  Stream<ConnectivityResult> connectionStream;
  ConnectivityResult connectivityResult;

  ConnectivityProvider() {
    try {
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
    notifyListeners();
    printIfDebug('Connectivity Status:\t' + connectivityResult.toString());
  }
}
