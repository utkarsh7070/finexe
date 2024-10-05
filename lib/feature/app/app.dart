import 'package:finexe/feature/base/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../base/routes/routes.dart';

class MyApp extends HookWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.login, // Define initial route
      onGenerateRoute: AppRoutes.generateRoute,

      // supportedLocales: AppLocalizations.supportedLocales,
      // localizationsDelegates: AppLocalizations.localizationsDelegate,
      title: 'Flutter Demo',
      theme: AppTheme().light(),
    );
  }
}