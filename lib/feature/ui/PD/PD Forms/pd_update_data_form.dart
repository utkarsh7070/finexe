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
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view_model.dart/pd_update_data_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateDataDorm extends ConsumerWidget {
  // const UpdateDataDorm({super.key});
  final String customerId;

  const UpdateDataDorm({super.key, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdUpdateData = ref.watch(getUpdatedDataProvider(customerId));
    if (kDebugMode) {
      print('customerId in UpdateDataDorm:: $customerId');
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          ApplicantForm(customerId: customerId),
          CoApplicantForm(customerId: customerId),
          CibilDetailsForm(customerId: customerId),
          // SamagraDetailsForm(customerId: customerId),
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


    //   pdUpdateData.when(
    //   data: (data) {
    //     return
    //       SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           ApplicantForm(customerId: customerId),
    //          CoApplicantForm(customerId: customerId),
    //           CibilDetailsForm(customerId: customerId),
    //           SamagraDetailsForm(customerId: customerId),
    //           PdAssetsForm(customerId: customerId),
    //           PoliceStationForm(customerId: customerId),
    //           IncomeDetailForm(customerId: customerId),
    //           RefrenceDetailsForm(customerId: customerId),
    //           TotalIncomeDetailsForm(customerId: customerId),
    //           Propertycollateral(customerId: customerId),
    //           LoanDetailsForm(customerId: customerId),
    //
    //           // WorkAndAgriCultureImages(customerId: customerId),//it will not used
    //           PendencyReject(customerId: customerId)
    //         ],
    //       ),
    //     );
    //   },
    //   error: (error, stackTrace) => const Text('data'),
    //   loading: () => const Center(child: CircularProgressIndicator()),
    // );
  }
}
