import 'package:advanced_search/advanced_search.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_existing_data/view/pd_existing_data_form.dart';

import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_update_data_form.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../pd_view_model/pd_form_viewmodel.dart';

class PdFormScreen extends ConsumerWidget {
  const PdFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSegment =
        ref.watch(segmentProvider); // Watch the selected segment
    final segmentNotifier = ref.read(segmentProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          color: AppColors.white,
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text("Customer Detail's"),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 19, color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              child: AdvancedSearch(
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
                  searchItems: []),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomSlidingSegmentedControl(
                fixedWidth: MediaQuery.of(context).size.width * 0.45,
                //  initialValue: customerState.selectedSegment,
                children: const {
                  1: Text('Existing Data'),
                  2: Text('Update Data'),
                },
                decoration: BoxDecoration(
                  color: const Color(0xFFD3D3D3),
                  borderRadius: BorderRadius.circular(8),
                ),
                thumbDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInToLinear,
                onValueChanged: (value) {
                  segmentNotifier.updateSegment(value);
                  print("Segment changed to: $value");
                },
              ),
            ),
            // const SizedBox(height: 10),
            Expanded(
              child: selectedSegment == 1
                  ? PdFilledForm() // Show Existing Data
                  : UpdateDataDorm(), // Show Update Data
            ),
          ],
        ),
      ),
    );
  }

  constSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }

  diveider(BuildContext context) {
    return Divider(
      indent: displayWidth(context) * 0.05,
      endIndent: displayWidth(context) * 0.05,
      color: Colors.grey, // Customize the color
      thickness: 1, // Set thickness for the border
    );
  }
}
