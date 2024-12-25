import 'dart:ui';

import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoConnectionOverlay extends StatelessWidget {
  const NoConnectionOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              height: displayHeight(context),
              width: displayWidth(context),
              child: Lottie.asset('assets/lottie/noInternet2.json',
                  fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}