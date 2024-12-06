import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/Income%20Details/view/main_income_details_fomr/new_income_form.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/applicant_detail.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/assets_form.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/bank_details_form.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/cibil_details.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/co-applicant_form.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/co-applicant_form2.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/gauranter_form.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/loan_details_form.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/pendency_reject_form.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/police_station_form.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/property_colaterals.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/refrence_details_form.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/samagra_details_form.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/total_income_form.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/co_applicant_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateDataDorm extends ConsumerWidget {
  const UpdateDataDorm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coApplicantsAsync = ref.watch(coApplicantProvider);
    return SingleChildScrollView(
      child: coApplicantsAsync.when(
        data: (coApplicants) {
          return Column(
            children: [
              ApplicantForm(), // Always show ApplicantForm
              // if (coApplicants.isNotEmpty)
              //   CoApplicantForm(data: coApplicants[0]),
              CoApplicantForm(data: coApplicants[0]),
              if (coApplicants.length > 1)
                CoApplicantSecondForm(data: coApplicants[1]),
              GauranterFormScreen(),
              BankDetailsForm(),
              CibilDetailsForm(),
              SamagraDetailsForm(),
              PdAssetsForm(),
              PoliceStationForm(),
              IncomeDetailForm(),
              TotalIncomeDetailsForm(),
              LoanDetailsForm(),
              RefrenceDetailsForm(),
              Propertycollateral(),
              PendencyReject()
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text("Error: $error")),
      ),
    );
  }
}





   // child: Column(
      //   children: [
      //     ApplicantForm(),
      //     CoApplicantForm(),
      //     CoApplicantSecondForm(),
      //     GauranterFormScreen(),
      //     BankDetailsForm(),
      //     CibilDetailsForm(),
      //     SamagraDetailsForm(),
      //     PdAssetsForm(),
      //     PoliceStationForm(),
      //     IncomeDetailForm(),
      //     TotalIncomeDetailsForm(),
      //     LoanDetailsForm(),
      //     RefrenceDetailsForm(),
      //     Propertycollateral(),
      //     PendencyReject()
      //   ],
      // ),