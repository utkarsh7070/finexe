import 'package:cached_network_image/cached_network_image.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Model/pd_request_list_model.dart';
import 'package:finexe/feature/ui/PD/pd_view_model/pd_request_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/utils/widget/custom_snackbar.dart';
import '../dialog/pd_request_dialog.dart';
import '../pd_view_model/pd_dash_viewmodel.dart';

class PdRequestScreen extends ConsumerWidget {
  const PdRequestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pditems = ref.watch(fetchpdRefuseandAcceptListProvider);
    final pdRequestViewModel = ref.watch(pdRequestProvider);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            color: Colors.white,
          ),
          backgroundColor: AppColors.white,
          title: const Text('PD Request'),
          centerTitle: true,
        ),
        body: pditems.when(
          data: (pdDataItems) {
            return Column(
              children: [
                Expanded(
                  child:
                      // pditems == null // Check for loading state
                      //     ? Center(child: CircularProgressIndicator())
                      //     :
                      pditems.value!.isEmpty // Check for empty state
                          ? const Center(
                              child: Text(
                                'No PD Requests found',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: pdDataItems.length,
                              itemBuilder: (context, index) {
                                final applicant = pdDataItems[index];
                                return itemCard(context, applicant,
                                    pdRequestViewModel, ref);
                              },
                            ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
          // error: (error, stackTrace) {
          //   print('Error: $error');
          //   return Center(
          //     child: Text('Data not found'),
          //   );
          // },
        ));
  }

  itemCard(BuildContext context, PDReqItems pdreitem,
      RequestApiService pdRequestViewModel, ref) {
    return Column(
      children: [
        Container(
          //  / padding: EdgeInsets.all(12),
          height: displayHeight(context) * 0.29,
          width: displayWidth(context) * 0.94,
          margin: EdgeInsets.only(top: displayHeight(context) * 0.02),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray),
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                  width: displayWidth(context),
                  height: displayHeight(context) * 0.05,
                  padding: EdgeInsets.only(
                      left: displayWidth(context) * 0.05,
                      top: displayHeight(context) * 0.01),
                  decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: Text(
                    pdreitem.customerFinId!,
                    textAlign: TextAlign.left,
                    style: AppStyles.whiteText16,
                  )),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: displayWidth(context) * 0.04,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    // child: Image.network(
                    //   pdreitem.customerPhoto!,
                    //   height: 62,
                    //   width: 62,
                    //   fit: BoxFit.cover,
                    // ),
                    child: CachedNetworkImage(
                      //'${Api.baseUrl}${samagradata.sSSMPhoto!}'
                      // imageUrl: pdreitem.customerPhoto!,
                      imageUrl: '${Api.baseUrl}${pdreitem.customerPhoto!}',
                      height: 56,
                      width: 56,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/no_internet.jpg',
                        height: 56,
                        width: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.02,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pdreitem.customerName??'',
                          style: AppStyles.blackText16,
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.01,
                        ),
                        Text(
                          'Address',
                          style: AppStyles.gray7Text,
                        ),
                        Text(
                          pdreitem.customerAddress??'NA',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppStyles.blacktext14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      pdRequestViewModel.pdRequestDefuse(pdreitem.sId!).then(
                        (value) {
                          if (value!) {

                            ref.refresh(fetchpdRefuseandAcceptListProvider);
                            ref.refresh(fetchPdRequestListProvider);
                            showCustomSnackBar(
                                context, 'Request Rejected', AppColors.green);
                          }
                        },
                      );
                      // PdRequestDialogue.requestAcceptDialogue(context: context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: 44,
                      width: displayWidth(context) * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.red, width: 1.5)),
                      child: const Text(
                        'Refuse',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.red),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      PdRequestDialogue.requestAcceptDialogue(
                          context: context, id: pdreitem.sId ?? '');
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: 44,
                      width: displayWidth(context) * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: AppColors.primary, width: 1.5)),
                      child: const Text(
                        'Accept',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
