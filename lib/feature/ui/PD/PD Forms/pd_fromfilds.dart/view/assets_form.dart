import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/asset_detail_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/asset_details_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/utils/widget/app_text_filed_login.dart';
import '../view_model.dart/asset_details_vmodel.dart';

// final isAssetProvider = StateProvider<bool>((ref) => false);
// final FetchData = StateProvider<bool>((ref) => false);
//
// class PdAssetsForm extends ConsumerStatefulWidget {
//   final String customerId;
//   const PdAssetsForm({super.key, required this.customerId});
//
//   @override
//   ConsumerState<PdAssetsForm> createState() => _PdAssetsFormState();
// }

class PdAssetsForm extends ConsumerWidget {
  final String customerId;

  PdAssetsForm({required this.customerId, super.key});

  // final _formKey = GlobalKey<FormState>();
//  late TextEditingController pdassetform_nameController = TextEditingController();
//  late TextEditingController pdassetform_purchaseController =
//       TextEditingController();
//  late  TextEditingController pdassetform_marketvalueController =
//       TextEditingController();

  // Initial set of controllers for the first member
  // final List<Map<String, TextEditingController>> memberControllers = [
  //   {
  //     'name': TextEditingController(),
  //     'purchase': TextEditingController(),
  //     'marketValue': TextEditingController(),
  //   }
  // ];
  // @override
  // void dispose() {
  //   // Dispose of each controller when the widget is removed
  //   // pdassetform_nameController.dispose();
  //   // pdassetform_purchaseController.dispose();
  //   // pdassetform_marketvalueController.dispose();
  //   for (var member in memberControllers) {
  //     member['name']?.dispose();
  //     member['purchase']?.dispose();
  //     member['marketValue']?.dispose();
  //   }
  //   super.dispose();
  // }

  // State variables for totals
  // State variables for totals
  // double totalMarketValue = 0;
  // double totalPurchaseValue = 0;
  // bool isInitialDataSet = false;
  // bool fetchDataBool = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(pdassetDetailsiewModelProvider);
    final appStateViewModel = ref.read(pdassetDetailsiewModelProvider.notifier);
    final getAssetData = ref.watch(assetsDetailsProvider(customerId));

    return ExpansionTile(
      title: const Text('Assets Detail’s'),
      onExpansionChanged: (expanded) {
        // ref.read(isAssetProvider.notifier).state = expanded;
        if (expanded) {
          if (getAssetData.value?.items?.assetDetails != null) {
            // Trigger data fetch when the tile is expanded
            ref.refresh(assetsDetailsProvider(customerId));
          }
        }
      },
      initiallyExpanded: false,
      children: [
        getAssetData.when(
          data: (data) {
            print('appState.assetsList.length  ${appState.assetsList.length}');
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 20),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: true,
                    itemCount: appState.assetsList.length,
                    itemBuilder: (context, index) {
                      print(appState.assetsList.length);
                      return Column(
                        children: [
                          AppFloatTextField(
                            initialValue: appState.assetsList[index].name,
                            textInputType: TextInputType.text,
                            inerHint: 'Name',
                            textInputAction: TextInputAction.next,
                          ),
                          constSizedbox(context),
                          AppFloatTextField(
                            initialValue:
                                appState.assetsList[index].purchaseValue,
                            onChange: (value) {
                              appStateViewModel.updatePurchase(value, index);
                            },
                            textInputType: TextInputType.number,
                            inerHint: 'Purchase values',
                            textInputAction: TextInputAction.next,
                          ),
                          constSizedbox(context),
                          AppFloatTextField(
                            initialValue:
                                appState.assetsList[index].marketValue,
                            onChange: (value) {
                              appStateViewModel.updateMarket(value, index);
                              // appStateViewModel.calculateMarket(value,index),
                            },
                            textInputType: TextInputType.number,
                            inerHint: 'Market values',
                            textInputAction: TextInputAction.next,
                          ),
                          constSizedbox(context),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  appStateViewModel.removeTodo(
                                      appState.assetsList[index].id);
                                },
                                icon: const Icon(Icons.remove_circle_outline,
                                    color: Colors.red),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: AppButton(
                      width: displayWidth(context) * 0.30,
                      bgColor: AppColors.white,
                      borderColor: AppColors.primary,
                      isBorderColor: true,
                      onTap: () {
                        appStateViewModel.addAssets();
                      },
                      label: 'Add More',
                    ),
                  ),
                  constSizedbox(context),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Total Market: ${appState.totalMarketValue}/-',
                      textAlign: TextAlign.left,
                      style: AppStyles.blacktext14,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Total Purchase: ${appState.totalPurchaseValue} /-',
                      textAlign: TextAlign.left,
                      style: AppStyles.blacktext14,
                    ),
                  ),
                  // constSizedbox(context),
                  Visibility(
                    visible: !appState.isLoading,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: AppButton(
                      onTap: () {
                        appStateViewModel.submitpdAssetDetailsForm(
                          context: context,
                          customerId: customerId,
                          pdType: 'creditPd',
                        );
                      },
                      width: displayWidth(context),
                      bgColor: AppColors.white,
                      borderColor: AppColors.primary,
                      isBorderColor: true,
                      label: 'Save Form',
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) => const Text('data'),
          loading: () => Center(child: CircularProgressIndicator()),
        )
      ],
    );
  }

  Widget constSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }

// Method to calculate totals
}
