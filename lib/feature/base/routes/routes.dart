import 'package:flutter/material.dart';
import '../../ui/Sales/DashBoard/view/dash_board.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/sales_on_boarding_form.dart';
import '../../ui/authenticate/forgot_passwaord/view/forgot_password_screen.dart';
import '../../ui/authenticate/view/login_screen.dart';
// import 'package:your_project_name/views/login_screen.dart';
// import 'package:your_project_name/views/user_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String forgot = '/forgot';
  static const String dashBoard = '/dashBoard';
  static const String saleForm = '/saleForm';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) =>   LoginScreen());
      case forgot:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
        case dashBoard:
        return MaterialPageRoute(builder: (_) => DashBoardScreen());
        case saleForm:
        return MaterialPageRoute(builder: (_) =>  SalesOnBoardingForm());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
