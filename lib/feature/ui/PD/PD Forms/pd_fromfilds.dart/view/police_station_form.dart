import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/police_view_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart'; // Adjust the path
// import '../../../../../../../base/utils/namespase/app_colors.dart';
import '../view_model.dart/police_view_modal.dart';
final isExpPoliceStationProvider = StateProvider<bool>((ref) => false);

class PoliceStationForm extends ConsumerStatefulWidget {
  // const PoliceStationForm({super.key});
  final String customerId;
  const PoliceStationForm({super.key, required this.customerId});
  @override
  ConsumerState<PoliceStationForm> createState() => _PoliceStationFormState();
}

class _PoliceStationFormState extends ConsumerState<PoliceStationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController policestationFormNameController =
      TextEditingController();
  final TextEditingController policestationFormAddressController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    policestationFormNameController.dispose();
    policestationFormAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access the ViewModel's state
    final appState = ref.watch(pdPoliceSubmitDataProvider);

    final isExpanded = ref.watch(isExpPoliceStationProvider);
    final policeDetails = ref.watch(policeDetailsProvider(widget.customerId));
    print('policegetData:: $policeDetails');

    return ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
          shape: const Border(
            bottom: BorderSide(color: Colors.grey), // Adjust color as needed
          ),
          title: const Text('Police Station'),
          onExpansionChanged: (expanded) {
            ref.read(isExpPoliceStationProvider.notifier).state = expanded;
            if (expanded) {
              // Trigger data fetch when the tile is expanded
              ref.refresh(policeDetailsProvider(widget.customerId));
            }
          },
          initiallyExpanded: isExpanded,
          children: [
            policeDetails.when(
                data: (policeData) {
                  if (policestationFormNameController.text.isEmpty) {
                    policestationFormNameController.text = policeData.stationName ?? '';
                    policestationFormAddressController.text =
                        policeData.stationAddress ?? '';
                  }
                  return  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: CustomTextFormField(
                            textInputType: TextInputType.name,
                            width: MediaQuery.of(context).size.width,
                            inerHint: 'Station Name',
                            onValidate: (value) {
                              if (value!.trim().isEmpty) {
                                return "This is a required field";
                              }
                              return null;
                            },
                            controller: policestationFormNameController,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Station Address TextField
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: CustomTextFormField(
                            inerHint: 'Station Address',
                            onValidate: (value) {
                              if (value!.trim().isEmpty) {
                                return "This is a required field";
                              }
                              return null;
                            },
                            controller: policestationFormAddressController,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Submit Button
                        ElevatedButton(
                          onPressed: () async {
                            ref
                                .read(pdPoliceSubmitDataProvider.notifier)
                                .submitpdPoloiceForm(
                              customerId:  widget.customerId,
                              pdType: 'creditPd',
                              //  policeStation: policeStation,
                              policeStaionaddress:
                              policestationFormAddressController.text,
                              policeStaionname:
                              policestationFormNameController.text,
                            ).then(
                              (value) {
                                if (value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColors.green,
                                      content: Text(
                                        'Form submitted successfully!',
                                        style: AppStyles.whiteText16,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColors.red,
                                      content: Text(
                                        'Faild to submit the form please try again',
                                        style: AppStyles.whiteText16,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          child: appState.isLoading == true
                              ? const SizedBox(
                            width: 24, // Specify the width
                            height: 24, // Specify the height
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 3,
                              key: ValueKey(
                                  'loading'), // Key for progress indicator
                            ),
                          )
                              : Text(
                            'Next',
                            style: AppStyles.whiteText16,
                          ),
                        ),
                        // ],
                      ],
                    ),
                  );
                },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
            )

          ],
        );

  }
}
