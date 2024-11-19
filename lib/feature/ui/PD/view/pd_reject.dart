import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/pd_view_model/pa_reject_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdRejectScreen extends ConsumerWidget {
  const PdRejectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdrejectitems = ref.watch(pdrejectViewModel);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.white,
        ),
        backgroundColor: AppColors.white,
        title: Text('PD Reject'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: pdrejectitems.length,
              itemBuilder: (context, index) {
                final items = pdrejectitems[index];
                //   return _buildApplicantDetails(context, applicant);
                return itemCard(context, items);
              },
            ),
          ),
        ],
      ),
    );
  }

  itemCard(BuildContext context, PdReject pdreitem) {
    return Column(
      children: [
        pdreitem.date == null || pdreitem.date!.isEmpty
            ? SizedBox.shrink()
            : Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: displayHeight(context) * 0.03),
                padding: EdgeInsets.only(left: displayWidth(context) * 0.05),
                child: Text(
                  pdreitem.date!,
                  textAlign: TextAlign.left,
                  style: AppStyles.gray7Text,
                ),
              ),
        Container(
          //  / padding: EdgeInsets.all(12),
          height: displayHeight(context) * 0.22,
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
                  decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: Text(
                    pdreitem.id,
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
                    child: Image.network(
                      pdreitem.imageUrl,
                      height: 62,
                      width: 62,
                      fit: BoxFit.cover,
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
                          pdreitem.name,
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
                          pdreitem.address,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppStyles.blacktext14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: displayHeight(context) * 0.02,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         // PdRequestDialogue.requestAcceptDialogue(context: context);
              //       },
              //       child: Container(
              //         padding: EdgeInsets.only(top: 10),
              //         height: 44,
              //         width: displayWidth(context) * 0.3,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(30),
              //             border: Border.all(color: AppColors.red, width: 1.5)),
              //         child: Text(
              //           'Refuse',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(color: AppColors.red),
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         PdRequestDialogue.requestAcceptDialogue(context: context);
              //       },
              //       child: Container(
              //         padding: EdgeInsets.only(top: 10),
              //         height: 44,
              //         width: displayWidth(context) * 0.3,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(30),
              //             border:
              //                 Border.all(color: AppColors.primary, width: 1.5)),
              //         child: Text(
              //           'Accept',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(color: AppColors.primary),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ],
    );
  }
}
