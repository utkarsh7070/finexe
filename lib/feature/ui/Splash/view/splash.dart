import 'dart:developer';

import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/ui/Splash/view_model/splash_vew_model.dart';
import 'package:finexe/feature/ui/authenticate/view/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(sessionProvider);
    log('asyncValue: ${asyncValue.toString()}');
    return asyncValue.when(
        data: (isLoggedIn) {
          Future.microtask(() {
            if (isLoggedIn) {
              Navigator.pushReplacementNamed(context,
                  AppRoutes.dashBoard); // Navigate to dashboard if logged in
            } else {
              Navigator.pushReplacementNamed(context,
                  AppRoutes.login); // Navigate to login if not logged in
            }
          });
          return Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(
                'assets/images/logo_finexe.png',
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            ),
          );
        },
        error: (error, stack) => Center(child: Text('Error: $error')),
        loading: () => Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/images/logo_finexe.png',
                  width: MediaQuery.of(context).size.width * 0.65,
                ),
              ),
            ));
  }
}
