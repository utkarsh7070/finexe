import 'package:advanced_search/advanced_search.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/routes/routes.dart';

class VisitPendingScreen extends ConsumerWidget {
  const VisitPendingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Stack(children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Text('Costomer Details'),
                            SizedBox(
                              height: displayHeight(context) * 0.01,
                            ),
                            customerDetails(context,
                                heading: 'Name', data: 'Prakash'),
                            customerDetails(context,
                                heading: 'Father Name', data: 'Karulal'),
                            customerDetails(context,
                                heading: 'Address', data: 'GRAM MANGALIYAGOWN, INDORE'),
                            customerDetails(context,
                                heading: 'LD BNumber', data: 'LD-7534'),
                            customerDetails(context,
                                heading: 'Contact Number', data: '2343525'),
                            customerDetails(context,
                                heading: 'EMI Amount', data: '8300'),
                            customerDetails(context,
                                heading: 'Old Due', data: '0'),
                            customerDetails(context,
                                heading: 'Net Due', data: '8,300'),
                            customerDetails(context,
                                heading: 'Partner', data: 'UGRO'),
                            SizedBox(height: displayHeight(context)*0.01,),
                            buttons(context,
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.updateVisit);
                                },
                                onTap1: () {},
                                text1: 'Update EMI',
                                text: 'Update Visit'),
                            buttons(context,
                                onTap: () {},
                                onTap1: () {},
                                text1: 'Map',
                                text: 'More Info')
                          ],
                        ),
                      )
                    ]),
                  );
                },
              ),
            ),
          )
        ],
      ),
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
          SizedBox(width: displayWidth(context)*0.01,),
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
}
