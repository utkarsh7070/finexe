
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/Income%20Details/view/main_income_details_fomr/new_income_form.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/applicant_detail.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/assets_form.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/cibil_details.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/co-applicant_form.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/loan_details_form.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/pendency_reject_form.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/police_station_form.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/property_colaterals.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/refrence_details_form.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/samagra_details_form.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/total_income_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateDataDorm extends ConsumerWidget {
  // const UpdateDataDorm({super.key});
  final String customerId;

  UpdateDataDorm({required this.customerId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('customerId in UpdateDataDorm:: ${customerId}');
    // final coApplicantsAsync = ref.watch(coAppl);
    return SingleChildScrollView(
      child:
           Column(
            children: [

              ApplicantForm(customerId: customerId), // Always show ApplicantForm
              // if (coApplicants.isNotEmpty)
              //   CoApplicantForm(data: coApplicants[0]),
              // CoApplicantForm(data: coApplicants[0]),
              CoApplicantForm(customerId: customerId),
              // if (coApplicants.length > 1)
              //   CoApplicantSecondForm(data: coApplicants[1]),
              // GauranterFormScreen(customerId: customerId),
              // BankDetailsForm(customerId: customerId),
              CibilDetailsForm(customerId: customerId),
              SamagraDetailsForm(customerId: customerId),
              PdAssetsForm(customerId: customerId),
              PoliceStationForm(customerId: customerId),
              IncomeDetailForm(customerId: customerId),
              RefrenceDetailsForm(customerId: customerId),
              TotalIncomeDetailsForm(customerId: customerId),
              Propertycollateral(customerId: customerId),
              LoanDetailsForm(customerId: customerId),

               // WorkAndAgriCultureImages(customerId: customerId),//it will not used
              PendencyReject(customerId: customerId)
            ],

      ),
    );
  }
  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   print('customerId in UpdateDataDorm:: ${customerId}');
  //   final coApplicantsAsync = ref.watch(coApplicantProvider(customerId));
  //   return SingleChildScrollView(
  //     child: coApplicantsAsync.when(
  //       data: (coApplicants) {
  //         return Column(
  //           children: [
  //             ApplicantForm(customerId: customerId), // Always show ApplicantForm
  //             // if (coApplicants.isNotEmpty)
  //             //   CoApplicantForm(data: coApplicants[0]),
  //             // CoApplicantForm(data: coApplicants[0]),
  //             CoApplicantForm(customerId: customerId),
  //             // if (coApplicants.length > 1)
  //             //   CoApplicantSecondForm(data: coApplicants[1]),
  //             GauranterFormScreen(customerId: customerId),
  //             BankDetailsForm(customerId: customerId),
  //             CibilDetailsForm(customerId: customerId),
  //             SamagraDetailsForm(customerId: customerId),
  //             PdAssetsForm(customerId: customerId),
  //             PoliceStationForm(customerId: customerId),
  //             IncomeDetailForm(customerId: customerId),
  //             TotalIncomeDetailsForm(customerId: customerId),
  //             LoanDetailsForm(customerId: customerId),
  //             RefrenceDetailsForm(customerId: customerId),
  //             Propertycollateral(customerId: customerId),
  //             WorkAndAgriCultureImages(customerId: customerId),
  //             PendencyReject(customerId: customerId)
  //           ],
  //         );
  //       },
  //       loading: () => const Center(child: CircularProgressIndicator()),
  //       error: (error, stackTrace) => Center(child: Text("Error: $error")),
  //     ),
  //   );
  // }
}




