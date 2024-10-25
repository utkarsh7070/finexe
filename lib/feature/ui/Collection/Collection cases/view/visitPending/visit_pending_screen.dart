import 'package:advanced_search/advanced_search.dart';
import 'package:finexe/feature/base/extentions/capital_letter.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/namespase/font_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/routes/routes.dart';
import '../../../../../base/utils/namespase/app_colors.dart';
import '../../../widget/Visit Pending Dialogs/clouser_dialog/clouser_dialog.dart';
import '../../../widget/Visit Pending Dialogs/map/map_dialog.dart';
import '../../../widget/Visit Pending Dialogs/update_emi_dialog/update_emi_dialog.dart';
import '../../../widget/Visit Pending Dialogs/update_visit_dialog/update_visit_dialog.dart';
import '../../model/visit_pending_items_model.dart';
import '../../view_model/visit_pending_view_model.dart';

class VisitPendingScreen extends ConsumerWidget {
  const VisitPendingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(fetchVisitPendingDataProvider);

    return data.when(
      data: (data) {
        List<ItemsDetails> listOfLists = data.map((map) {
          return ItemsDetails.fromJson(map);
        }).toList();
        return Container(
          padding: const EdgeInsets.all(16),
          height: displayHeight(context),
          width: displayWidth(context),
          child: Column(
            children: [
              AdvancedSearch(
                // data: ,
                maxElementsToDisplay: 10,
                singleItemHeight: 50,
                borderColor: Colors.grey,
                minLettersForSearch: 0,
                selectedTextColor: const Color(0xFF3363D9),
                fontSize: 14,
                borderRadius: 12.0,
                hintText: 'Search Me',
                cursorColor: Colors.blueGrey,
                autoCorrect: false,
                focusedBorderColor: Colors.blue,
                searchResultsBgColor: const Color(0xFAFAFA),
                disabledBorderColor: Colors.cyan,
                enabledBorderColor: Colors.black,
                enabled: true,
                caseSensitive: false,
                inputTextFieldBgColor: Colors.white10,
                clearSearchEnabled: true,
                itemsShownAtStart: 10,
                searchMode: SearchMode.CONTAINS,
                showListOfResults: true,
                unSelectedTextColor: Colors.black54,
                verticalPadding: 10,
                horizontalPadding: 10,
                hideHintOnTextInputFocus: true,
                hintTextColor: Colors.grey,
                onItemTap: (index, value) {
                  if (kDebugMode) {
                    print("selected item index is $index");
                  }
                },
                onSearchClear: () {
                  if (kDebugMode) {
                    print("Cleared Search");
                  }
                },
                onSubmitted: (searchText, listOfResults) {
                  print("Submitted: " + searchText);
                },
                onEditingProgress: (searchText, listOfResults) {
                  print("TextEdited: " + searchText);
                  print("LENGTH: " + listOfResults.length.toString());
                },

                searchItems: [],
              ),
              SizedBox(
                height: displayHeight(context) * 0.03,
              ),
              Expanded(
                child: SizedBox(
                  height: displayHeight(context),
                  width: displayWidth(context),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = listOfLists[index];

                      // List<String> valueList = item.values.toList();

                      return Card(
                          elevation: 5,
                          child: IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: AppColors.primaryLight),
                                          padding: const EdgeInsets.all(10),
                                          height: displayHeight(context) * 0.09,
                                          width: displayWidth(context) * 0.25,
                                          child: Center(
                                              child: Text(
                                            item.ld!,
                                            style: AppStyles.cardTextStyle16
                                                .copyWith(
                                                    color: AppColors.primary,
                                                    fontSize:
                                                        FontSize.fontSizeS),
                                          )),
                                        ),
                                        SizedBox(
                                          width: displayWidth(context) * 0.02,
                                        ),
                                        // Text(
                                        //  ' ${item.customerName} S/O ${item.fatherName}'.capitalize(),
                                        //   maxLines: 2,
                                        //   style: AppStyles.nameText.copyWith(fontSize: FontSize.fontSize),
                                        // ),
                                        customerNameDetails(patner: item.partner!,
                                          context,
                                          heading: 'Customer Name',
                                          data:
                                              '${item.customerName} S/O ${item.fatherName}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: AppColors.dividerColors,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Address',
                                            style: AppStyles.subTextStyle,
                                          ),
                                          SizedBox(
                                              width:
                                                  displayWidth(context) * 0.65,
                                              child: Text(
                                                  item.address!.capitalize(),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppStyles
                                                      .subHeadingW500
                                                      .copyWith(
                                                          fontWeight: FontWeight
                                                              .w600))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: displayHeight(context) * 0.01,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          MapDialog()
                                              .mapDialog(context: context,lat: item.lat!,log: item.longValue!);
                                        },
                                        child: Container(
                                          height: displayHeight(context) * 0.06,
                                          width: displayWidth(context) * 0.15,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: AppColors.primaryLight),
                                          child: Center(
                                              child: Image.asset(
                                            'assets/images/Location.png',
                                            height: 20,
                                            width: 20,
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Number',
                                            style: AppStyles.subTextStyle,
                                          ),
                                          Text(
                                            item.mobile!,
                                            style: AppStyles.subHeadingW500
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, AppRoutes.moreInfo);
                                        },
                                        child: Container(
                                          height: displayHeight(context) * 0.06,
                                          width: displayWidth(context) * 0.15,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: AppColors.primaryLight),
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/info.png',
                                                height: 20,
                                                width: 20,
                                              ),
                                              const Text('info')
                                            ],
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: displayWidth(context) * 0.25,
                                        height: displayHeight(context) * 0.06,
                                        decoration: const BoxDecoration(
                                            color: AppColors.bgGreenLight,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: emiText(
                                            text1: 'EMI',
                                            text2: '₹${item.emiAmount}',
                                            text1Color: Colors.green,
                                            text2Color: Colors.green),
                                      ),
                                      SizedBox(
                                        width: displayWidth(context) * 0.25,
                                        height: displayHeight(context) * 0.06,
                                        child: emiText(
                                            text1: 'Net Due',
                                            text2: '₹${item.netDue}',
                                            text1Color: AppColors.gray,
                                            text2Color: AppColors.black),
                                      ),
                                      SizedBox(
                                        width: displayWidth(context) * 0.25,
                                        height: displayHeight(context) * 0.06,
                                        child: emiText(
                                            text1: 'Old Due',
                                            text2: '₹${item.oldDue}',
                                            text1Color: AppColors.gray,
                                            text2Color: AppColors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.01,
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: AppColors.dividerColors,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            UpdateVisitDialog()
                                                .updateVisitDialog(item:item,
                                                    context: context,index: index);
                                          },
                                          child: textPreIcon(context,
                                              image: 'assets/images/money.png',
                                              text: 'Update Visit',
                                              textColor: Colors.green),
                                        ),
                                        VerticalDivider(
                                          width: displayWidth(context) * 0.05,
                                          color: AppColors.dividerColors,
                                          thickness: 1,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            ClosuerDialog().closuerDialog(
                                                item:item,
                                                context: context,index: index);
                                          },
                                          child: textPreIcon(context,
                                              image:
                                                  'assets/images/money_beg.png',
                                              text: 'Closure',
                                              textColor: Colors.blue),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  AppButton(
                                    width: displayWidth(context),
                                    onTap: () {
                                      UpdateEmiDialog()
                                          .updateEmiDialog(context: context,index: index,item: item);
                                    },
                                    label: 'Update EMI',
                                    textStyle:
                                        const TextStyle(color: AppColors.white),
                                  )
                                ],
                              ),
                            ),
                          )

                          // Stack(children: [
                          //   Container(
                          //     padding: const EdgeInsets.all(16),
                          //     child: Column(
                          //       children: [
                          //         const Text('Costomer Details'),
                          //         SizedBox(
                          //           height: displayHeight(context) * 0.01,
                          //         ),
                          //         customerDetails(context,
                          //             heading: 'Name', data: 'Prakash'),
                          //         customerDetails(context,
                          //             heading: 'Father Name', data: 'Karulal'),
                          //         customerDetails(context,
                          //             heading: 'Address', data: 'GRAM MANGALIYAGOWN, INDORE'),
                          //         customerDetails(context,
                          //             heading: 'LD BNumber', data: 'LD-7534'),
                          //         customerDetails(context,
                          //             heading: 'Contact Number', data: '2343525'),
                          //         customerDetails(context,
                          //             heading: 'EMI Amount', data: '8300'),
                          //         customerDetails(context,
                          //             heading: 'Old Due', data: '0'),
                          //         customerDetails(context,
                          //             heading: 'Net Due', data: '8,300'),
                          //         customerDetails(context,
                          //             heading: 'Partner', data: 'UGRO'),
                          //         SizedBox(height: displayHeight(context)*0.01,),
                          //         buttons(context,
                          //             onTap: () {
                          //               Navigator.pushNamed(context, AppRoutes.updateVisit);
                          //             },
                          //             onTap1: () {},
                          //             text1: 'Update EMI',
                          //             text: 'Update Visit'),
                          //         buttons(context,
                          //             onTap: () {},
                          //             onTap1: () {},
                          //             text1: 'Map',
                          //             text: 'More Info')
                          //       ],
                          //     ),
                          //   )
                          // ]),
                          );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Text('data');
      },
      loading: () {
        return CircularProgressIndicator();
      },
    );
  }

  Widget customerDetails(context,
      {required String heading, required String data}) {
    return SizedBox(
      width: displayWidth(context),
      child: Row(
        children: [
          Text(
            '$heading:',
            style: AppStyles.subTextStyle,
          ),
          Text(
            data,
            style: AppStyles.subTextStyle,
          ),
        ],
      ),
    );
  }

  Widget buttons(context,
      {required String text,
      required VoidCallback onTap,
      required String text1,
      required VoidCallback onTap1}) {
    return SizedBox(
      width: displayWidth(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppButton(
            textStyle: AppStyles.buttonLightTextStyle,
            // height: displayHeight(context) * 0.,
            width: displayWidth(context) * 0.35,
            label: text,
            onTap: onTap,
            bgColor: Colors.blue,
          ),
          SizedBox(
            width: displayWidth(context) * 0.01,
          ),
          AppButton(
            textStyle: AppStyles.buttonLightTextStyle,
            // height: displayHeight(context) * 0.5,
            width: displayWidth(context) * 0.35,
            label: text1,
            onTap: onTap1,
            bgColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget customerNameDetails(context,
      {required String heading, required String data,required String patner}) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   '$heading:',
          //   style: AppStyles.subTextStyle,
          // ),
          SizedBox(
            width: displayWidth(context) * 0.55,
            child: Text(
              maxLines: 2,
              data.capitalize(),
              style: AppStyles.nameText.copyWith(
                  fontSize: FontSize.fontSize, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
              width: displayWidth(context) * 0.20,
              height: displayHeight(context) * 0.04,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.primaryOrange),
              child: const Center(
                  child: Text(
                'UGRO',
                style: TextStyle(color: Colors.orange),
              )))
        ],
      ),
    );
  }

  Widget emiText(
      {required String text1,
      required String text2,
      required Color text1Color,
      required Color text2Color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: AppStyles.subHeadingW500
              .copyWith(color: text1Color, fontSize: 12),
        ),
        Text(text2,
            style: AppStyles.subHeadingW500
                .copyWith(color: text2Color, fontWeight: FontWeight.w600))
      ],
    );
  }

  Widget textPreIcon(context,
      {required String image, required String text, required Color textColor}) {
    return Row(
      children: [
        SizedBox(
          child: Row(
            children: [
              Image.asset(
                image,
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: displayWidth(context) * 0.03,
              ),
              Text(
                text,
                style: AppStyles.cardTextStyle16.copyWith(color: textColor),
              )
            ],
          ),
        )
      ],
    );
  }
}
