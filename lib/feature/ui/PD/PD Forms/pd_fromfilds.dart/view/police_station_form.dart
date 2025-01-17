import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/police_view_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Adjust the path
// import '../../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../../../base/utils/widget/custom_snackbar.dart';
import '../view_model.dart/police_view_modal.dart';
final isExpPoliceStationProvider = StateProvider<bool>((ref) => false);


class PoliceStationForm extends ConsumerWidget {
  final String customerId;

  const PoliceStationForm({super.key, required this.customerId});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appState = ref.watch(pdPoliceSubmitDataProvider);
    final appStateViewModel = ref.read(pdPoliceSubmitDataProvider.notifier);
    final isExpanded = ref.watch(isExpPoliceStationProvider);
    final policeDetails = ref.watch(policeDetailsProvider(customerId));
    print('policegetData:: $policeDetails');

    return ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 16, bottom: 10,right: 16),
          shape: const Border(
            bottom: BorderSide(color: Colors.grey), // Adjust color as needed
          ),
          title: const Text('Police Station'),
          onExpansionChanged: (expanded) {
            ref.read(isExpPoliceStationProvider.notifier).state = expanded;
            if (expanded) {
              // Trigger data fetch when the tile is expanded
              ref.refresh(policeDetailsProvider(customerId));
            }
          },
          initiallyExpanded: false,
          children: [
            policeDetails.when(
                data: (policeData) {
                  return Column(
                    children: [
                      // const SizedBox(height: 10),
                      AppFloatTextField(
                        initialValue: appState.stationName,
                        textInputType: TextInputType.name,
                        // width: MediaQuery.of(context).size.width,
                        inerHint: 'Station Name',
                        onChange: (value) {
                          appStateViewModel.updateStationName(value);
                        },
                      ),
                      const SizedBox(height: 10),
                      // Station Address TextField
                      AppFloatTextField(
                        initialValue: appState.stationAddress,
                        inerHint: 'Station Address',
                        onChange: (value) {
                          appStateViewModel.updateStationAddress(value);
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10),
                      // Submit Button
                      AppButton(
                        width: displayWidth(context),
                        isBorderColor: true,
                        borderColor: AppColors.primary,
                        bgColor: AppColors.white,

                        label: 'Save Form',
                        onTap: () async {
                          ref
                              .read(pdPoliceSubmitDataProvider.notifier)
                              .submitpdPoloiceForm(
                            context:  context,
                            customerId:  customerId,

                          ).then(
                            (value) {
                              if (value) {
                                showCustomSnackBar(
                                    context,'Form Saved successfully!', Colors.green);
                              }
                            },
                          );
                        },
                        // child: appState.isLoading == true
                        //     ? const SizedBox(
                        //   width: 24, // Specify the width
                        //   height: 24, // Specify the height
                        //   child: CircularProgressIndicator(
                        //     color: AppColors.white,
                        //     strokeWidth: 3,
                        //     key: ValueKey(
                        //         'loading'), // Key for progress indicator
                        //   ),
                        // )
                        //     : Text(
                        //   'Save Form',
                        //   style: AppStyles.whiteText16,
                        // ),
                      ),
                      // ],
                    ],
                  );
                },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
            )

          ],
        );

  }
}
