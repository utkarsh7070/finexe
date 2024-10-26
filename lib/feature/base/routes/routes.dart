import 'package:finexe/feature/Punch_In_Out/view/attendance.dart';
import 'package:finexe/feature/ui/Collection/Collection_home_dashboard/home_collection_view/DashboardScreen.dart';
import 'package:finexe/feature/ui/Sales/NewLone/view/new_loan_screen.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/co_applicant_screen.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/referance/referance_details.dart';
import 'package:finexe/feature/ui/Splash/view/splash.dart';
import 'package:flutter/material.dart';
import '../../ui/Collection/Collection cases/view/cases_screen.dart';
import '../../ui/Collection/Collection cases/view/visitPending/more_info_screen.dart';
import '../../ui/Sales/DashBoard/view/dash_board.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/applicant_form/applicant_form_2.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/applicant_form/application_form3.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/applicant_form/appliction_form.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/co_applicant_form2.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/co_applicant_form3.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/guarantor_form/guarantor_form.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/guarantor_form/guarantor_form_2.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/guarantor_form/guarantor_form_3.dart';
import '../../ui/authenticate/forgot_passwaord/view/forgot_password_screen.dart';
import '../../ui/authenticate/view/login_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String forgot = '/forgot';
  static const String dashBoard = '/dashBoard';
  static const String saleApplicationForm = '/saleApplicationForm';
  static const String saleApplicationForm2 = '/saleApplicationForm2';
  static const String saleApplicationForm3 = '/saleApplicationForm3';
  static const String saleCoApplicationForm1 = '/saleCoApplicationForm1';
  static const String saleCoApplicationForm2 = '/saleCoApplicationForm2';
  static const String saleCoApplicationForm3 = '/saleCoApplicationForm3';
  static const String saleGuarantorForm = '/saleGuarantorForm';
  static const String saleGuarantorForm1 = '/saleGuarantorForm1';
  static const String saleGuarantorForm2 = '/saleGuarantorForm2';
  static const String saleGuarantorForm3 = '/saleGuarantorForm3';
  static const String saleReferenceForm = '/saleReferenceForm';
  static const String newLone = '/newLone';
  static const String attendance = '/attendance';
  static const String cases = '/cases';
  static const String updateVisit = '/updateVisit';
  static const String moreInfo = '/moreInfo';
  static const String collectionHome = '/collectionHome';
  static const String attendanceScreen = '/attendanceScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case collectionHome:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case forgot:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case attendance:
        return MaterialPageRoute(builder: (_) => const AttendanceScreen());
      case dashBoard:
        return
            // MaterialPageRoute(builder: (_) =>
            PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MyDashBoardWidget(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      // const MyDashBoardWidget()
      // );
      case saleApplicationForm:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ApplicationDetails(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600));

      // MaterialPageRoute(builder: (_) => const ApplicationDetails());
      case saleApplicationForm2:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ApplicantForm2(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600));
      // return MaterialPageRoute(builder: (_) => const ApplicantForm2());
      case saleApplicationForm3:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ApplicantForm3(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600));
      // return MaterialPageRoute(builder: (_) => const ApplicantForm3());
      case saleCoApplicationForm1:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CoApplicantScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600));
      // return MaterialPageRoute(builder: (_) => const CoApplicantForm1());
      case saleCoApplicationForm2:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CoApplicantForm2(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600));
      // return MaterialPageRoute(builder: (_) => const CoApplicantForm2());
      case saleCoApplicationForm3:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CoApplicantForm3(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600));
      // return MaterialPageRoute(builder: (_) => const CoApplicantForm3());
      // case saleGuarantorForm:
      // return MaterialPageRoute(builder: (_) =>  const GuarantorForm());
      case saleGuarantorForm1:
        return MaterialPageRoute(builder: (_) => const GuarantorDetails());
      case saleGuarantorForm2:
        return MaterialPageRoute(builder: (_) => const GuarantorForm2());
      case saleGuarantorForm3:
        return MaterialPageRoute(builder: (_) => const GuarantorForm3());
      case saleReferenceForm:
        return MaterialPageRoute(builder: (_) => ReferenceDetails());
      case newLone:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const NewLoanScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600));
      // return MaterialPageRoute(builder: (_) => const NewLoanScreen());

      case cases:
        return MaterialPageRoute(builder: (_) => const CollectionCasesScreen());
      // case updateVisit:
      //   return MaterialPageRoute(builder: (_) => const UpdateVisit());
      case moreInfo:
        return MaterialPageRoute(
            builder: (_) => const CollectionMoreInfoScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
