import 'package:advanced_search/advanced_search.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/pd_view_model/pd_dash_viewmodel.dart';
import 'package:finexe/feature/ui/PD/view/pd_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdScreen extends ConsumerStatefulWidget {
  const PdScreen({super.key});

  @override
  ConsumerState<PdScreen> createState() => _PdScreenState();
}

class _PdScreenState extends ConsumerState<PdScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //AddBodDialog().addAlbumDialog(context, ref);
    ref.read(bodStatusNotifierProvider.notifier).checkBodStatus(context, ref);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final items = ref.watch(itemProvider);
    final gridItems = ref.watch(griditemProvider);
    var _scaffoldKey = GlobalKey<ScaffoldState>();
    final pdITems = ref.watch(pdItemsProvider);
    return Scaffold(
      key: _scaffoldKey,
      drawer: PdDrawer(),
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        actions: [
          GestureDetector(
            // onTap: _toggleDialog,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage:
                    //  data.imageUrl != null
                    //     ? NetworkImage('${Api.imageUrl}${data.imageUrl}')
                    //     :
                    const AssetImage('assets/images/prof.jpeg'),
                // Placeholder image
                onBackgroundImageError: (error, stackTrace) {
                  // Set a default image if the API image fails to load
                },
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
      ),
      // drawer: const PDSideDrawer(),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            constantSizedbox(context),
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
                  // if (kDebugMode) {
                  //   print("selected item index is $index");
                  // }
                },
                onSearchClear: () {
                  // if (kDebugMode) {
                  //   print("Cleared Search");
                  // }
                },
                onSubmitted: (searchText, listOfResults) {
                  print("Submitted: " + searchText);
                },
                onEditingProgress: (searchText, listOfResults) {
                  print("TextEdited: " + searchText);
                  print("LENGTH: " + listOfResults.length.toString());
                },
                searchItems: []),
            constantSizedbox(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PD Request',
                  style: AppStyles.fonteighten,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.pdrequest);
                    },
                    child: Text('See All', style: AppStyles.subHeading))
              ],
            ),
            constantSizedbox(context),
            Container(
              height: displayHeight(context) * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffF4F4F4),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Container(
                    width: displayWidth(context) * 0.4,
                    margin: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.imageUrl,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item.subtitle,
                                style: TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: displayHeight(context) * 0.03,
            ),
            SizedBox(
              height: displayHeight(context) * 0.47,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                //  padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 15,
                  mainAxisSpacing: displayHeight(context) * 0.02,
                  childAspectRatio: 0.95, // Adjust the height of each item
                ),
                itemCount: gridItems.length,
                itemBuilder: (context, index) {
                  final item = gridItems[index];
                  return SquareBox(
                    backImage: item.backImage,
                    iconImage: item.iconImage,
                    title: item.title,
                    stitle: item.subtitle,
                    context: context,
                    titleColor: Colors.white,
                    stitleColor: Colors.grey[300]!,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Refused Case',
                  style: AppStyles.fonteighten,
                ),
                Text('See All', style: AppStyles.subHeading)
              ],
            ),
            //  constantSizedbox(context),
            ListView.builder(
              shrinkWrap:
                  true, // Allows ListView to take up only the required height
              physics: NeverScrollableScrollPhysics(),
              itemCount: pdITems.length,
              itemBuilder: (context, index) {
                final items = pdITems[index];
                return Container(
                  height: displayHeight(context) * 0.06,
                  // width: displayWidth(context) * 0.9,
                  decoration: BoxDecoration(color: Colors.white),
                  margin: EdgeInsets.only(top: displayHeight(context) * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                items.imageUrl,
                                height: displayHeight(context) * 0.09,
                                width: displayWidth(context) * 0.12,
                                fit: BoxFit.cover,
                              )),
                          SizedBox(width: displayWidth(context) * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items.title,
                                style: AppStyles.blacktext14,
                              ),
                              Text(
                                items.subtitle,
                                style: AppStyles.subHeading,
                              ),
                            ],
                          ),
                        ],
                      ),
                      //SizedBox(width: displayWidth(context) * 0.4),
                      Text(
                        items.initialPd,
                        style: AppStyles.blueText,
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      )),
    );
  }

  constantSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }

  Widget SquareBox({
    required String backImage,
    required String iconImage,
    required String title,
    required String stitle,
    required BuildContext context,
    required Color titleColor,
    required Color stitleColor,
  }) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(
            image: AssetImage(backImage),
            // height: displayHeight(context) * 0.16,
            // width: displayWidth(context) * 0.5,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: displayHeight(context) * 0.025,
          left: displayWidth(context) * 0.02,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage(iconImage),
                height: displayHeight(context) * 0.09,
                width: displayWidth(context) * 0.18,
              ),
              constantSizedbox(context),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: titleColor,
                ),
              ),
              Text(
                stitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: stitleColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
