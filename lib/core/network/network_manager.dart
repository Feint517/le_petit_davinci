import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  //? initialize the network manager and setup a stream to continually check the network status
  @override
  void onInit() {
    super.onInit();
    print('onInit ==> ${_connectionStatus.value}');
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  //? initial connectivity check
  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } on PlatformException {
      _connectionStatus.value = ConnectivityResult.none;
    }
  }

  //? update connection status based on changes in connectivity and show a relevant popup for no internet connection
  void _updateConnectionStatus(List<ConnectivityResult> result) {
    _connectionStatus.value = result.first;
    print(_connectionStatus.value);

    // if (_connectionStatus.value == ConnectivityResult.none) {
    //   CustomLoaders.showSnackBar(
    //     type: SnackBarType.warning,
    //     title: 'No Internet Connection',
    //     message: "Please make sure you're connected to the internet",
    //   );
    // }
    // if (_connectionStatus.value != ConnectivityResult.wifi) {
    //   CustomLoaders.showSnackBar(
    //     type: SnackBarType.succes,
    //     title: 'Conntected!',
    //   );
    // }
  }

  //? check the internet connection status
  //? returns true if connected and false if not
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result.contains(ConnectivityResult.none)) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  //? dispose or close the active connectivity stream
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
