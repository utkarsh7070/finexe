import 'dart:ui';

import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/asset_detail_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/asset_details_vmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Submit Data Models/asset_detail_model.dart';
import '../view_model.dart/asset_details_vmodel.dart';
final isAssetProvider = StateProvider<bool>((ref) => false);
final FetchData = StateProvider<bool>((ref) => false);

class PdAssetsForm extends ConsumerStatefulWidget {
  final String customerId;
  PdAssetsForm({required this.customerId});

  @override
  ConsumerState<PdAssetsForm> createState() => _PdAssetsFormState();
}

class _PdAssetsFormState extends ConsumerState<PdAssetsForm> {
  final _formKey = GlobalKey<FormState>();
//  late TextEditingController pdassetform_nameController = TextEditingController();
//  late TextEditingController pdassetform_purchaseController =
//       TextEditingController();
//  late  TextEditingController pdassetform_marketvalueController =
//       TextEditingController();

  // Initial set of controllers for the first member
  final List<Map<String, TextEditingController>> memberControllers = [
    {
      'name': TextEditingController(),
      'purchase': TextEditingController(),
      'marketValue': TextEditingController(),
    }
  ];
  @override
  void dispose() {
    // Dispose of each controller when the widget is removed
    // pdassetform_nameController.dispose();
    // pdassetform_purchaseController.dispose();
    // pdassetform_marketvalueController.dispose();
    for (var member in memberControllers) {
      member['name']?.dispose();
      member['purchase']?.dispose();
      member['marketValue']?.dispose();
    }
    super.dispose();
  }

  // State variables for totals
  // State variables for totals
  double totalMarketValue = 0;
  double totalPurchaseValue = 0;
  bool isInitialDataSet = false;
  bool fetchDataBool = false;

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(pdassetDetailsiewModelProvider);
    //getAssetDetailFromProvider
    final _isExpanded = ref.watch(isAssetProvider);
    // final fetchDataBool = ref.watch(FetchData);
    // if(fetchDataBool)
    final getAssetData = ref.watch(getAssetDetailFromProvider(widget.customerId));
    print('fetchDataBool build:: $fetchDataBool');

    if(getAssetData.value?.items?.assetDetails!=null){
      if (!isInitialDataSet) {
        totalMarketValue =
            getAssetData.value?.items!.total!.totalMarketValue!.toDouble() ?? 0;
        totalPurchaseValue =
            getAssetData.value?.items!.total!.totalPurchaseValue!.toDouble() ??
                0;

        memberControllers.clear();
        // Populate family members list with data from the server
        for (var member in getAssetData.value!.items!.assetDetails!) {
          memberControllers.add({
            'name': TextEditingController(text: member.name ?? ''),
            'purchase':
            TextEditingController(text: member.purchaseValue ?? ''),
            'marketValue':
            TextEditingController(text: member.marketValue ?? ''),
          });
        }
        isInitialDataSet = true; // Prevent further overwrites
      }
    }


    return

         ExpansionTile(
          title: const Text('Assets Detail’s'),
           onExpansionChanged: (expanded) {
             ref.read(isAssetProvider.notifier).state = expanded;
             if (expanded) {
               if(getAssetData.value?.items?.assetDetails!=null)
               // Trigger data fetch when the tile is expanded
               ref.refresh(getAssetDetailFromProvider(widget.customerId));
             }
           },
           initiallyExpanded: _isExpanded,
          children: [
               Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 20),
                  child: Column(
                    children: [
                      constSizedbox(context),
                      // Loop through each member's controllers to generate form fields
                      for (int i = 0; i < memberControllers.length; i++) ...[
                        constSizedbox(context),
                        CustomTextFormField(
                          textInputType: TextInputType.text,
                          inerHint: 'Name',
                          onValidate: (value) {
                            if (value!.trim().isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          controller: memberControllers[i]['name']!,
                          textInputAction: TextInputAction.next,
                        ),
                        constSizedbox(context),
                        CustomTextFormField(
                          onChange: (value) => calculateTotals(),
                          textInputType: TextInputType.number,
                          width: displayWidth(context) * 0.8,
                          inerHint: 'Purchase values',
                          onValidate: (value) {
                            if (value!.trim().isEmpty) {
                              return "Enter purchase value";
                            }
                            return null;
                          },
                          controller: memberControllers[i]['purchase']!,
                          textInputAction: TextInputAction.next,
                        ),
                        constSizedbox(context),
                        CustomTextFormField(
                          onChange: (value) => calculateTotals(),
                          textInputType: TextInputType.number,
                          width: displayWidth(context) * 0.8,
                          inerHint: 'Market values',
                          onValidate: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter market value";
                            }
                            return null;
                          },
                          controller: memberControllers[i]['marketValue']!,
                          textInputAction: TextInputAction.next,
                        ),
                        constSizedbox(context),
                        i > 0
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  memberControllers.removeAt(i);
                                });
                              },
                              icon: Icon(Icons.remove_circle_outline,
                                  color: Colors.red),
                            ),
                          ],
                        )
                            : SizedBox.shrink()
                      ],

                      Container(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // Add a new set of controllers for the new member
                              memberControllers.add({
                                'name': TextEditingController(),
                                'purchase': TextEditingController(),
                                'marketValue': TextEditingController(),
                              });
                            });
                          },
                          child: const Text(
                            'Add More',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      constSizedbox(context),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Total Market: $totalMarketValue /-',
                          textAlign: TextAlign.left,
                          style: AppStyles.blacktext14,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Total Purchase: $totalPurchaseValue /-',
                          textAlign: TextAlign.left,
                          style: AppStyles.blacktext14,
                        ),
                      ),
                      constSizedbox(context),

                      ElevatedButton(
                        onPressed: () {
                          List<AssetDetails> assetDetails = [];

                          // Add the first set of controllers
                          // assetDetails.add(AssetDetails(
                          //   name: pdassetform_nameController.text,
                          //   purchaseValue: pdassetform_purchaseController.text,
                          //   marketValue: pdassetform_marketvalueController.text,
                          // ));

                          // Add other members from `memberControllers`
                          for (var member in memberControllers) {
                            assetDetails.add(AssetDetails(
                              name: member['name']!.text,
                              purchaseValue: member['purchase']!.text,
                              marketValue: member['marketValue']!.text,
                            ));
                          }
                          ref
                              .read(pdassetDetailsiewModelProvider.notifier)
                              .submitpdAssetDetailsForm(
                            context: context,
                              customerId:  widget.customerId,
                              pdType: 'creditPd',
                              assetDetailList: assetDetails,
                              totalMarketV: totalMarketValue,
                              totalPurchaseV: totalPurchaseValue)
                              .then(
                                (value) {
                              if (value) {
                                // ref.read(isAssetProvider.notifier).state = expanded;
                                // setState(() {
                                //   fetchDataBool = true;
                                //   print('fetchDataBool:: $fetchDataBool');
                                // });
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     backgroundColor: AppColors.green,
                                //     content: Text(
                                //       'Form Saved successfully!',
                                //       style: AppStyles.whiteText16,
                                //     ),
                                //   ),
                                // );
                                showCustomSnackBar(
                                    context,'Form Saved successfully!', Colors.green);
                                ref.refresh(getAssetDetailFromProvider(widget.customerId));

                              }
                              // else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       backgroundColor: AppColors.red,
                              //       content: Text(
                              //         'Faild to save the form please try again',
                              //         style: AppStyles.whiteText16,
                              //       ),
                              //     ),
                              //   );
                              // }
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
                            : const Text(
                          'Save Form',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),



        //     getAssetData.when(
        //       data: (geetingAssetData) {
        //
        // print(
        //     'marketValue: ${geetingAssetData.items!.assetDetails![0].marketValue}');
        // print(
        //     'purchaseValue: ${geetingAssetData.items!.assetDetails![0].purchaseValue}');
        // print(
        //     'totalMarketValue: ${geetingAssetData.items!.total!.totalMarketValue!.toDouble()}');
        // if (!isInitialDataSet) {
        //   totalMarketValue =
        //       geetingAssetData.items!.total!.totalMarketValue!.toDouble() ?? 0;
        //   totalPurchaseValue =
        //       geetingAssetData.items!.total!.totalPurchaseValue!.toDouble() ??
        //           0;
        //
        //   memberControllers.clear();
        //   // Populate family members list with data from the server
        //   for (var member in geetingAssetData.items!.assetDetails!) {
        //     memberControllers.add({
        //       'name': TextEditingController(text: member.name ?? ''),
        //       'purchase':
        //       TextEditingController(text: member.purchaseValue ?? ''),
        //       'marketValue':
        //       TextEditingController(text: member.marketValue ?? ''),
        //     });
        //   }
        //   isInitialDataSet = true; // Prevent further overwrites
        // }
        // return Form(
        //   key: _formKey,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 15,right: 20),
        //     child: Column(
        //       children: [
        //         constSizedbox(context),
        //         // Loop through each member's controllers to generate form fields
        //         for (int i = 0; i < memberControllers.length; i++) ...[
        //           constSizedbox(context),
        //           CustomTextFormField(
        //             textInputType: TextInputType.text,
        //             inerHint: 'Name',
        //             onValidate: (value) {
        //               if (value!.trim().isEmpty) {
        //                 return "This field is required";
        //               }
        //               return null;
        //             },
        //             controller: memberControllers[i]['name']!,
        //             textInputAction: TextInputAction.next,
        //           ),
        //           constSizedbox(context),
        //           CustomTextFormField(
        //             onChange: (value) => calculateTotals(),
        //             textInputType: TextInputType.number,
        //             width: displayWidth(context) * 0.8,
        //             inerHint: 'Purchase values',
        //             onValidate: (value) {
        //               if (value!.trim().isEmpty) {
        //                 return "Enter purchase value";
        //               }
        //               return null;
        //             },
        //             controller: memberControllers[i]['purchase']!,
        //             textInputAction: TextInputAction.next,
        //           ),
        //           constSizedbox(context),
        //           CustomTextFormField(
        //             onChange: (value) => calculateTotals(),
        //             textInputType: TextInputType.number,
        //             width: displayWidth(context) * 0.8,
        //             inerHint: 'Market values',
        //             onValidate: (value) {
        //               if (value!.trim().isEmpty) {
        //                 return "Please enter market value";
        //               }
        //               return null;
        //             },
        //             controller: memberControllers[i]['marketValue']!,
        //             textInputAction: TextInputAction.next,
        //           ),
        //           constSizedbox(context),
        //           i > 0
        //               ? Row(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: [
        //               IconButton(
        //                 onPressed: () {
        //                   setState(() {
        //                     memberControllers.removeAt(i);
        //                   });
        //                 },
        //                 icon: Icon(Icons.remove_circle_outline,
        //                     color: Colors.red),
        //               ),
        //             ],
        //           )
        //               : SizedBox.shrink()
        //         ],
        //
        //         Container(
        //           alignment: Alignment.centerLeft,
        //           child: ElevatedButton(
        //             onPressed: () {
        //               setState(() {
        //                 // Add a new set of controllers for the new member
        //                 memberControllers.add({
        //                   'name': TextEditingController(),
        //                   'purchase': TextEditingController(),
        //                   'marketValue': TextEditingController(),
        //                 });
        //               });
        //             },
        //             child: const Text(
        //               'Add Member',
        //               style: TextStyle(color: Colors.white),
        //             ),
        //           ),
        //         ),
        //         constSizedbox(context),
        //         Container(
        //           alignment: Alignment.centerLeft,
        //           child: Text(
        //             'Total Market: $totalMarketValue /-',
        //             textAlign: TextAlign.left,
        //             style: AppStyles.blacktext14,
        //           ),
        //         ),
        //         Container(
        //           alignment: Alignment.centerLeft,
        //           child: Text(
        //             'Total Purchase: $totalPurchaseValue /-',
        //             textAlign: TextAlign.left,
        //             style: AppStyles.blacktext14,
        //           ),
        //         ),
        //         constSizedbox(context),
        //
        //         ElevatedButton(
        //           onPressed: () {
        //             List<AssetDetails> assetDetails = [];
        //
        //             // Add the first set of controllers
        //             // assetDetails.add(AssetDetails(
        //             //   name: pdassetform_nameController.text,
        //             //   purchaseValue: pdassetform_purchaseController.text,
        //             //   marketValue: pdassetform_marketvalueController.text,
        //             // ));
        //
        //             // Add other members from `memberControllers`
        //             for (var member in memberControllers) {
        //               assetDetails.add(AssetDetails(
        //                 name: member['name']!.text,
        //                 purchaseValue: member['purchase']!.text,
        //                 marketValue: member['marketValue']!.text,
        //               ));
        //             }
        //             ref
        //                 .read(pdassetDetailsiewModelProvider.notifier)
        //                 .submitpdAssetDetailsForm(
        //                 customerId:  widget.customerId,
        //                 pdType: 'creditPd',
        //                 assetDetailList: assetDetails,
        //                 totalMarketV: totalMarketValue,
        //                 totalPurchaseV: totalPurchaseValue)
        //                 .then(
        //                   (value) {
        //                 if (value) {
        //                   // ref.read(isAssetProvider.notifier).state = expanded;
        //                   setState(() {
        //                     fetchDataBool = true;
        //                     print('fetchDataBool:: $fetchDataBool');
        //                   });
        //                   ScaffoldMessenger.of(context).showSnackBar(
        //                     SnackBar(
        //                       backgroundColor: AppColors.green,
        //                       content: Text(
        //                         'Form Saved successfully!',
        //                         style: AppStyles.whiteText16,
        //                       ),
        //                     ),
        //                   );
        //                 } else {
        //                   ScaffoldMessenger.of(context).showSnackBar(
        //                     SnackBar(
        //                       backgroundColor: AppColors.red,
        //                       content: Text(
        //                         'Faild to save the form please try again',
        //                         style: AppStyles.whiteText16,
        //                       ),
        //                     ),
        //                   );
        //                 }
        //               },
        //             );
        //           },
        //           child: appState.isLoading == true
        //               ? const SizedBox(
        //             width: 24, // Specify the width
        //             height: 24, // Specify the height
        //             child: CircularProgressIndicator(
        //               color: AppColors.white,
        //               strokeWidth: 3,
        //               key: ValueKey(
        //                   'loading'), // Key for progress indicator
        //             ),
        //           )
        //               : const Text(
        //             'Save Form',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
        //
        //
        //         },
        //       loading: () => const Center(child: CircularProgressIndicator()),
        //       error: (error, stackTrace) => Center(child: Text('Error: $error')),
        //     )
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
  void calculateTotals() {
    double marketTotal = 0;
    double purchaseTotal = 0;

    // Include the first set of controllers
    // if (pdassetform_marketvalueController.text.isNotEmpty) {
    //   marketTotal +=
    //       double.tryParse(pdassetform_marketvalueController.text) ?? 0;
    // }
    // if (pdassetform_purchaseController.text.isNotEmpty) {
    //   purchaseTotal +=
    //       double.tryParse(pdassetform_purchaseController.text) ?? 0;
    // }

    // Add values from memberControllers

    for (var member in memberControllers) {
      if (member['marketValue'] != null ||
          member['marketValue']!.text.isNotEmpty) {
        marketTotal += double.tryParse(member['marketValue']!.text) ?? 0;
      }
      if (member['purchase'] != null || member['purchase']!.text.isNotEmpty) {
        purchaseTotal += double.tryParse(member['purchase']!.text) ?? 0;
      }
    }

    setState(() {
      totalMarketValue = marketTotal;
      totalPurchaseValue = purchaseTotal;
    });
  }
}
