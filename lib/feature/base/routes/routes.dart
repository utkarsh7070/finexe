import 'package:finexe/feature/Punch_In_Out/view/attendance.dart';
import 'package:finexe/feature/ui/Collection/Collection_home_dashboard/home_collection_view/DashboardScreen.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/view/bank_details.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/view/education_details.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/view/employee_basic_details.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/view/employment_history.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/view/upload_documents.dart';
import 'package:finexe/feature/ui/HRMS/LeaveManagement/view/hrms_dashboard_screen.dart';
import 'package:finexe/feature/ui/PD/view/pd_completed.dart';
import 'package:finexe/feature/ui/Sales/NewLone/view/new_loan_screen.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/co_applicant_screen.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/referance/referance_details.dart';
import 'package:finexe/feature/ui/Splash/view/splash.dart';
import 'package:flutter/material.dart';
import '../../Eod/view/addEod.dart';
import '../../Eod/view/all_task.dart';
import '../../Eod/view/bodlist.dart';
import '../../ui/Collection/Collection cases/view/cases_screen.dart';
import '../../ui/Collection/Collection cases/view/visitPending/more_info_screen.dart';
import '../../ui/HRMS/EmployeeJoiningForm/view/family_details.dart';
import '../../ui/PD/PD Forms/pd_existing_data/view/pd_existing_data_form.dart';
import '../../ui/PD/PD Forms/pd_form_screen.dart';
import '../../ui/PD/view/pd_approved.dart';
import '../../ui/PD/view/pd_dashboard_screen.dart';
import '../../ui/PD/view/pd_pending.dart';
import '../../ui/PD/view/pd_reject.dart';
import '../../ui/PD/view/pd_request.dart';
import '../../ui/Sales/DashBoard/view/dash_board.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/applicant_form/applicant_form_2.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/applicant_form/application_form3.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/applicant_form/appliction_form.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/applicant_form/bottom_sheet/applicant_otp_screen.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/co_applicant_form2.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/co_applicant_form3.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/guarantor_form/guarantor_form_1.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/guarantor_form/guarantor_form_2.dart';
import '../../ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/guarantor_form/guarantor_form_3.dart';
import '../../ui/authenticate/forgot_passwaord/view/forgot_password_screen.dart';
import '../../ui/authenticate/view/login_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String forgot = '/forgot';
  static const String dashBoard = '/dashBoard';
  static const String casesDetails = '/casesDetails';
  static const String saleApplicationForm = '/saleApplicationForm';
  static const String saleApplicationForm2 = '/saleApplicationForm2';
  static const String saleApplicationForm3 = '/saleApplicationForm3';
  static const String saleCoApplicationForm1 = '/saleCoApplicationForm1';
  static const String saleCoApplicationForm2 = '/saleCoApplicationForm2';
  static const String saleCoApplicationForm3 = '/saleCoApplicationForm3';
  static const String saleGuarantorForm1 = '/saleGuarantorForm1';
  static const String saleGuarantorForm2 = '/saleGuarantorForm2';
  static const String saleGuarantorForm3 = '/saleGuarantorForm3';
  static const String saleReferenceForm = '/saleReferenceForm';
  static const String saleApplicationVerify = '/saleApplicationVerify';
  static const String saleCoApplicationVerify = '/saleCoApplicationVerify';

  static const String newLone = '/newLone';
  static const String attendance = '/attendance';
  static const String cases = '/cases';
  static const String updateVisit = '/updateVisit';
  static const String moreInfo = '/moreInfo';
  static const String collectionHome = '/collectionHome';
  static const String attendanceScreen = '/attendanceScreen';
  static const String pdscreen = '/pdscreen';
  static const String pdpending = '/pdpending';
  static const String pdrequest = '/pdrequest';
  static const String pdformscreen = '/pdformscreen';
  static const String pdreject = '/pdreject';
  static const String pdComplete = '/pdComplete';
  static const String pdapprove = '/pdapprove'; //BODScreen
  static const String bodscreen = '/bodscreen';
  static const String eodscreen = '/eodscreen';
  static const String getalltask = '/getalltask'; //CustomerDetail
  static const String pdfilledform = '/pdfilledform';
  static const String hrms = '/hrms';
  static const String employeeBasicDetails = '/employeeBasicDetails';
  static const String familyDetails = '/familyDetails';
    static const String educationalDetails = '/educationalDetails';
        static const String employmentHistory = '/employmentHistory';
        static const String uploadDocuments='/uploadDocuments';

    

  static const String bankDetails = '/bankDetails';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case collectionHome:
        return MaterialPageRoute(builder: (_) => const CollectionDashboardScreen());
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
        final arguments = settings.arguments as Map<String, dynamic>?;
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
                return  ApplicationDetails(arguments??{});},
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
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
            const GuarantorDetails(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600));
      /*  case casesDetails:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
            const CasesDetails(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600));*/
      case saleGuarantorForm2:
        return MaterialPageRoute(builder: (_) => const GuarantorForm2());
      case saleGuarantorForm3:
        return MaterialPageRoute(builder: (_) => const GuarantorForm3());
      case saleReferenceForm:
        return MaterialPageRoute(builder: (_) => const ReferenceDetails());
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

        case saleApplicationVerify:

        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ApplicationVerify(),
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
     /* case moreInfo:
        return MaterialPageRoute(
            builder: (_) => const CollectionMoreInfoScreen());*/
     /* case moreInfo:
        return MaterialPageRoute(
          builder: (context) => CollectionMoreInfoScreen(
            index: (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>)['index'] ?? 0,
          ),
        );*/

      case moreInfo:
        return MaterialPageRoute(
          builder: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

            // Safely access the index from the arguments, defaulting to 0 if null
            final index = arguments?['index'] ?? 0;

            return CollectionMoreInfoScreen(index: index);
          },
        );
      case pdfilledform:
        final customerId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => PdFilledForm(customerId: customerId,));
      case pdformscreen:
        final customerId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) =>  PdFormScreen(customerId: customerId,));
      case eodscreen:
        return MaterialPageRoute(builder: (_) => const EODScreenAdd());
      case bodscreen:
        return MaterialPageRoute(builder: (_) => const BODScreen());
      case getalltask:
        return MaterialPageRoute(builder: (_) => const GetAllTask());
      case pdpending:
        return MaterialPageRoute(builder: (_) => const PDPendingScreen());
      case pdscreen:
        return MaterialPageRoute(builder: (_) => const PdScreen());
      case pdrequest:
        return MaterialPageRoute(builder: (_) => const PdRequestScreen());
      case pdreject:
        return MaterialPageRoute(builder: (_) => const PdRejectScreen());
        case employeeBasicDetails:
        return MaterialPageRoute(builder: (_) =>  const EmployeeBasicDetails());
        case familyDetails:
        return MaterialPageRoute(builder: (_) =>  const FamilyDetails());
        case pdComplete:
        return MaterialPageRoute(builder: (_) => const PdCompletedScreen());
      case pdapprove:
        return MaterialPageRoute(builder: (_) => const PdApprovedScreen());
        case hrms:
        return MaterialPageRoute(builder: (_) =>  const HRMSDashboardScreen());
        case bankDetails:
        return MaterialPageRoute(builder: (_) =>   const BankDetails());
         case educationalDetails:
        return MaterialPageRoute(builder: (_) =>   const EducationDetails());
         case employmentHistory:
        return MaterialPageRoute(builder: (_) =>   const EmploymentHistory());
         case uploadDocuments:
        return MaterialPageRoute(builder: (_) =>   const UploadDocuments());

        
        

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
