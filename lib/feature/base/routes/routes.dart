import 'package:finexe/feature/Punch_In_Out/Attendance/vew/attendance.dart';
import 'package:finexe/feature/ui/Collection/cases/view/cases_screen.dart';
import 'package:finexe/feature/ui/Sales/NewLone/view/new_loan_screen.dart';
import 'package:flutter/material.dart';
import '../../ui/Collection/cases/view/UpdateVisit/update_ visit_screen.dart';
import '../../ui/Sales/DashBoard/view/dash_board.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/sales_on_boarding_form.dart';
import '../../ui/authenticate/forgot_passwaord/view/forgot_password_screen.dart';
import '../../ui/authenticate/view/login_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String forgot = '/forgot';
  static const String dashBoard = '/dashBoard';
  static const String saleForm = '/saleForm';
  static const String newLone = '/newLone';
  static const String attendance = '/attendance';
  static const String cases = '/cases';
  static const String updateVisit = '/updateVisit';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) =>   const LoginScreen());
      case forgot:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
        case dashBoard:
        return MaterialPageRoute(builder: (_) => const DashBoardScreen());
        case saleForm:
        return MaterialPageRoute(builder: (_) =>  const SalesOnBoardingForm());
        case newLone:
        return MaterialPageRoute(builder: (_) =>  NewLoanScreen());
        // case attendance:
        // return MaterialPageRoute(builder: (_) =>   const AttendanceScreen());
        case cases:
        return MaterialPageRoute(builder: (_) =>   CasesScreen());
        case updateVisit:
        return MaterialPageRoute(builder: (_) =>   UpdateVisit());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
