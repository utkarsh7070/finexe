import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../base/utils/namespase/app_style.dart';
import '../../../../../base/utils/namespase/display_size.dart';

class CollectionDue extends ConsumerWidget {
  const CollectionDue({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return
      const Center(child: Text('IN DEVELOPMENT'));
    // Container(
    //   padding: const EdgeInsets.all(16),
    //   height: displayHeight(context),
    //   width: displayWidth(context),
    //   child: Column(
    //     children: [
    //       // AdvancedSearch(
    //       //   // data: ,
    //       //   maxElementsToDisplay: 10,
    //       //   singleItemHeight: 50,
    //       //   borderColor: Colors.grey,
    //       //   minLettersForSearch: 0,
    //       //   selectedTextColor: const Color(0xFF3363D9),
    //       //   fontSize: 14,
    //       //   borderRadius: 12.0,
    //       //   hintText: 'Search Me',
    //       //   cursorColor: Colors.blueGrey,
    //       //   autoCorrect: false,
    //       //   focusedBorderColor: Colors.blue,
    //       //   searchResultsBgColor: const Color(0xFAFAFA),
    //       //   disabledBorderColor: Colors.cyan,
    //       //   enabledBorderColor: Colors.black,
    //       //   enabled: true,
    //       //   caseSensitive: false,
    //       //   inputTextFieldBgColor: Colors.white10,
    //       //   clearSearchEnabled: true,
    //       //   itemsShownAtStart: 10,
    //       //   searchMode: SearchMode.CONTAINS,
    //       //   showListOfResults: true,
    //       //   unSelectedTextColor: Colors.black54,
    //       //   verticalPadding: 10,
    //       //   horizontalPadding: 10,
    //       //   hideHintOnTextInputFocus: true,
    //       //   hintTextColor: Colors.grey,
    //       //   onItemTap: (index, value) {
    //       //     if (kDebugMode) {
    //       //       print("selected item index is $index");
    //       //     }
    //       //   },
    //       //   onSearchClear: () {
    //       //     if (kDebugMode) {
    //       //       print("Cleared Search");
    //       //     }
    //       //   },
    //       //   onSubmitted: (searchText, listOfResults) {
    //       //     print("Submitted: " + searchText);
    //       //   },
    //       //   onEditingProgress: (searchText, listOfResults) {
    //       //     print("TextEdited: " + searchText);
    //       //     print("LENGTH: " + listOfResults.length.toString());
    //       //   },
    //       //
    //       //   searchItems:[]
    //       // ),
    //       SizedBox(
    //         height: displayHeight(context) * 0.03,
    //       ),
    //       Expanded(
    //         child: SizedBox(
    //           height: displayHeight(context),
    //           width: displayWidth(context),
    //           child: ListView.builder(
    //             itemCount: data.length,
    //             itemBuilder: (context, index) {
    //               final item = listOfLists[index];
    //
    //               // List<String> valueList = item.values.toList();
    //
    //               return Card(
    //                   elevation: 5,
    //                   child: IntrinsicHeight(
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(15.0),
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           SizedBox(
    //                             child: Row(
    //                               crossAxisAlignment:
    //                               CrossAxisAlignment.start,
    //                               mainAxisAlignment:
    //                               MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 customerNameDetails(
    //                                   mobile: item.mobile!,
    //                                   context,
    //                                   heading: 'Customer Name',
    //                                   data:
    //                                   '${item.customerName} S/O ${item.fatherName}',
    //                                 ),
    //                                 GestureDetector(
    //                                   onTap: () {
    //                                     Navigator.push(
    //                                       context,
    //                                       MaterialPageRoute(
    //                                         builder: (context) =>
    //                                             CollectionMoreInfoScreen(
    //                                                 index: index),
    //                                       ),
    //                                     );
    //                                   },
    //                                   child: Center(
    //                                       child: Image.asset(
    //                                         'assets/images/info.png',
    //                                         height: 20,
    //                                         width: 20,
    //                                       )),
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: displayHeight(context) * 0.02,
    //                           ),
    //                           Row(
    //                             mainAxisAlignment:
    //                             MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Center(
    //                                   child: Text(
    //                                     item.ld!,
    //                                     style: AppStyles.cardTextStyle16
    //                                         .copyWith(
    //                                         color: AppColors.primary,
    //                                         fontSize: FontSize.fontSizeS),
    //                                   )),
    //                               Container(
    //                                   padding: EdgeInsets.all(6),
    //                                   decoration: const BoxDecoration(
    //                                       borderRadius: BorderRadius.only(
    //                                           topLeft: Radius.circular(10),
    //                                           bottomRight:
    //                                           Radius.circular(10)),
    //                                       color: AppColors.primaryOrange),
    //                                   child:  Center(
    //                                       child: Text(
    //                                         item.partner!,
    //                                         style:
    //                                         const TextStyle(color: Colors.orange),
    //                                       ))),
    //                             ],
    //                           ),
    //                           const Divider(
    //                             thickness: 1,
    //                             color: AppColors.dividerColors,
    //                             indent: 10,
    //                             endIndent: 10,
    //                           ),
    //                           Row(
    //                             mainAxisAlignment:
    //                             MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               Column(
    //                                 crossAxisAlignment:
    //                                 CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     'Address',
    //                                     style: AppStyles.subTextStyle,
    //                                   ),
    //                                   SizedBox(
    //                                       width:
    //                                       displayWidth(context) * 0.65,
    //                                       child: Text(
    //                                           item.address!.capitalize(),
    //                                           maxLines: 3,
    //                                           overflow:
    //                                           TextOverflow.ellipsis,
    //                                           style: AppStyles
    //                                               .subHeadingW500
    //                                               .copyWith(
    //                                               fontWeight: FontWeight
    //                                                   .w600))),
    //                                 ],
    //                               ),
    //                               SizedBox(
    //                                 height: displayHeight(context) * 0.01,
    //                               ),
    //                               GestureDetector(
    //                                 onTap: () {
    //                                   MapDialog().mapDialog(
    //                                       context: context,
    //                                       lat: item.lat!,
    //                                       log: item.longValue!);
    //                                 },
    //                                 child: Container(
    //                                   padding: EdgeInsets.all(10),
    //                                   decoration:  BoxDecoration(shape: BoxShape.circle,
    //                                       // borderRadius: BorderRadius.all(
    //                                       //     Radius.circular(10)),
    //                                       color: AppColors.primaryLight),
    //                                   child: Center(
    //                                       child: Image.asset(
    //                                         'assets/images/Location.png',
    //                                         height: 20,
    //                                         width: 20,
    //                                       )),
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //
    //                           SizedBox(
    //                             height: displayHeight(context) * 0.02,
    //                           ),
    //                           Row(
    //                             mainAxisAlignment:
    //                             MainAxisAlignment.spaceAround,
    //                             children: [
    //                               Container(
    //                                 width: displayWidth(context) * 0.25,
    //                                 height: displayHeight(context) * 0.06,
    //                                 decoration: const BoxDecoration(
    //                                     color: AppColors.bgGreenLight,
    //                                     borderRadius: BorderRadius.all(
    //                                         Radius.circular(10))),
    //                                 child: emiText(
    //                                     text1: 'EMI',
    //                                     text2: '₹${item.emiAmount}',
    //                                     text1Color: Colors.green,
    //                                     text2Color: Colors.green),
    //                               ),
    //                               SizedBox(
    //                                 width: displayWidth(context) * 0.25,
    //                                 height: displayHeight(context) * 0.06,
    //                                 child: emiText(
    //                                     text1: 'Net Due',
    //                                     text2: '₹${item.netDue}',
    //                                     text1Color: AppColors.gray,
    //                                     text2Color: AppColors.black),
    //                               ),
    //                               SizedBox(
    //                                 width: displayWidth(context) * 0.25,
    //                                 height: displayHeight(context) * 0.06,
    //                                 child: emiText(
    //                                     text1: 'Old Due',
    //                                     text2: '₹${item.oldDue}',
    //                                     text1Color: AppColors.gray,
    //                                     text2Color: AppColors.black),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: displayHeight(context) * 0.02,
    //                           ),
    //                           // const Divider(
    //                           //   thickness: 1,
    //                           //   color: AppColors.dividerColors,
    //                           //   indent: 10,
    //                           //   endIndent: 10,
    //                           // ),
    //                           Row(
    //                             mainAxisAlignment:
    //                             MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               SizedBox(
    //                                 width: displayWidth(context)*0.37,
    //                                 child: ElevatedButton(
    //                                     style: ElevatedButton.styleFrom(side: BorderSide(color: AppColors.primary),
    //                                       shape: RoundedRectangleBorder(
    //                                         borderRadius: BorderRadius.circular(10),
    //                                       ),),
    //                                     onPressed: () {
    //                                       UpdateVisitDialog()
    //                                           .updateVisitDialog(
    //                                           item: item,
    //                                           context: context,
    //                                           index: index);
    //                                     }, child: Text('Update Visit',style:  const TextStyle(color: AppColors.primary),)),
    //                               ),
    //                               SizedBox(
    //                                 width: displayWidth(context)*0.37,
    //                                 child: ElevatedButton(
    //                                     style: ElevatedButton.styleFrom(side: BorderSide(color: AppColors.primary),
    //                                       shape: RoundedRectangleBorder(
    //                                         borderRadius: BorderRadius.circular(10),
    //                                       ),),
    //                                     onPressed: () {
    //                                       ClosuerDialog().closuerDialog(
    //                                           item: item,
    //                                           context: context,
    //                                           index: index);
    //                                     }, child: Text('Closure',style:  const TextStyle(color: AppColors.primary),)),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: displayHeight(context) * 0.01,
    //                           ),
    //                           SizedBox(
    //                             width: displayWidth(context),
    //                             child: ElevatedButton(
    //                                 style: ElevatedButton.styleFrom(side: BorderSide(color: AppColors.primary),
    //                                   shape: RoundedRectangleBorder(
    //                                     borderRadius: BorderRadius.circular(10),
    //                                   ),),
    //                                 onPressed: () {
    //                                   UpdateEmiDialog().updateEmiDialog(
    //                                       context: context,
    //                                       index: index,
    //                                       item: item);
    //                                 }, child: Text('Update EMI',style:  const TextStyle(color: AppColors.primary),)),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ));
    //             },
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
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
      {required String heading, required String data}) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$heading:',
            style: AppStyles.subTextStyle,
          ),
          Text(
            data,
            style: AppStyles.nameText,
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
