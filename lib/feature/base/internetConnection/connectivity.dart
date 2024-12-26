import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, List<ConnectivityResult> result)
      builder;
  const ConnectivityBuilder({super.key, required this.builder});

  @override
  State<ConnectivityBuilder> createState() => _ConnectivityBuilderState();
}

class _ConnectivityBuilderState extends State<ConnectivityBuilder> {
   

  List<ConnectivityResult> _connectivityresult = [ConnectivityResult.none];
  @override
  void initState() {

    super.initState();

    _initializeConectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityresult = result;
      });
    });
  }



  Future<void> _initializeConectivity() async {
    _connectivityresult = await Connectivity().checkConnectivity();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _connectivityresult);
  }
}