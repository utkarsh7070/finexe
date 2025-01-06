
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/pd_view_model/pd_dash_viewmodel.dart';
import 'package:finexe/feature/ui/PD/view/pd_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/api/api.dart';
import '../../../base/utils/widget/app_button.dart';
import '../../../base/utils/widget/app_text_filed_login.dart';

class PdScreen extends ConsumerStatefulWidget {
  const PdScreen({super.key});

  @override
  ConsumerState<PdScreen> createState() => _PdScreenState();
}

class _PdScreenState extends ConsumerState<PdScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   //AddBodDialog().addAlbumDialog(context, ref);
  //   // ref.read(bodStatusNotifierProvider.notifier).checkBodStatus(context, ref);
  //
  //
  // }

  @override
  Widget build(
    BuildContext context,
  ) {
    // final items = ref.watch(itemProvider);
    final pdRequestList = ref.watch(fetchPdRequestListProvider);
    final pdRefuseList = ref.watch(fetchPdRefuseCasetProvider);
    final gridItems = ref.watch(griditemProvider);
    var scaffoldKey = GlobalKey<ScaffoldState>();
    // final pdITems = ref.watch(pdItemsProvider);
    return NetworkListener(
      context: context,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const PdDrawer(),
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
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
      
              children: [
                constantSizedBox(context),
                // AdvancedSearch(
                //     // data: ,
                //     maxElementsToDisplay: 10,
                //     singleItemHeight: 50,
                //     borderColor: Colors.grey,
                //     minLettersForSearch: 0,
                //     selectedTextColor: const Color(0xFF3363D9),
                //     fontSize: 14,
                //     borderRadius: 12.0,
                //     hintText: 'Search Me',
                //     cursorColor: Colors.blueGrey,
                //     autoCorrect: false,
                //     focusedBorderColor: Colors.blue,
                //     searchResultsBgColor: const Color(0xFAFAFA),
                //     disabledBorderColor: Colors.cyan,
                //     enabledBorderColor: Colors.black,
                //     enabled: true,
                //     caseSensitive: false,
                //     inputTextFieldBgColor: Colors.white10,
                //     clearSearchEnabled: true,
                //     itemsShownAtStart: 10,
                //     searchMode: SearchMode.CONTAINS,
                //     showListOfResults: true,
                //     unSelectedTextColor: Colors.black54,
                //     verticalPadding: 10,
                //     horizontalPadding: 10,
                //     hideHintOnTextInputFocus: true,
                //     hintTextColor: Colors.grey,
                //     onItemTap: (index, value) {
                //       // if (kDebugMode) {
                //       //   print("selected item index is $index");
                //       // }
                //     },
                //     onSearchClear: () {
                //       // if (kDebugMode) {
                //       //   print("Cleared Search");
                //       // }
                //     },
                //     onSubmitted: (searchText, listOfResults) {
                //       print("Submitted: " + searchText);
                //     },
                //     onEditingProgress: (searchText, listOfResults) {
                //       print("TextEdited: " + searchText);
                //       print("LENGTH: " + listOfResults.length.toString());
                //     },
                //     searchItems: []),
                constantSizedBox(context),
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
                constantSizedBox(context),
                pdRequestList.when(
                    data: (data) =>
                        Container(
                          height: displayHeight(context) * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xffF4F4F4),
                          ),
                          child:data.isEmpty || data.isEmpty?
                          const Center(child: Text('No Request avialable'),):
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final item = data[index];
                              return Container(
                                width: displayWidth(context) * 0.4,
                                margin: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    // ClipRRect(
                                    //   borderRadius: BorderRadius.circular(8),
                                    //   child: Image.network(
                                    //     item.imageUrl,
                                    //     width: 56,
                                    //     height: 56,
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    // ),
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
                                        imageUrl:
                                            '${Api.baseUrl}${data[index].customerPhoto!}',
                                        height: 56,
                                        width: 56,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/images/no_internet.jpg',
                                          height: 56,
                                          width: 56,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.customerName ?? '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            item.customerFinId ?? '',
                                            style:
                                                const TextStyle(color: Colors.grey),
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
                    error: (error, stackTrace) {
                      return const Text('');
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                      //   Shimmer.fromColors(
                      //   baseColor: Colors.grey[300]!,
                      //   highlightColor: Colors.grey[100]!,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: 5, // Adjust the count based on your needs
                      //     itemBuilder: (context, index) {
                      //       return ListTile(
                      //         title: Container(
                      //           height: 10,
                      //           width: 50,
                      //           color: Colors.white,
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // );
                    }),
      
                // SizedBox(
                //   height: displayHeight(context) * 0.03,
                // ),
                constantSizedBox(context),
      
                SizedBox(
                  height: displayHeight(context) * 0.47,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
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
                      return squareBox(
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
                pdRefuseList.when(
                  data: (refuseItemsByPD) {
                  return
                    refuseItemsByPD.isEmpty?
                    const Text('No refused cases'):
                    ListView.builder(
                    shrinkWrap:
                    true, // Allows ListView to take up only the required height
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: refuseItemsByPD.length,
                    itemBuilder: (context, index) {
                      final items = refuseItemsByPD[index];
                      return Container(
                        height: displayHeight(context) * 0.06,
                        // width: displayWidth(context) * 0.9,
                        decoration: const BoxDecoration(color: Colors.white),
                        margin: EdgeInsets.only(top: displayHeight(context) * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // ClipRRect(
                                //     borderRadius: BorderRadius.circular(10),
                                //     child: Image.network(
                                //       items.imageUrl,
                                //       height: displayHeight(context) * 0.09,
                                //       width: displayWidth(context) * 0.12,
                                //       fit: BoxFit.cover,
                                //     )),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: items.customerPhoto??'',
                                    // imageUrl: data[index].customerPhoto??'',
                                    height: displayHeight(context) * 0.09,
                                    width: displayWidth(context) * 0.12,
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
                                SizedBox(width: displayWidth(context) * 0.03),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      items.customerName??'',
                                      style: AppStyles.blacktext14,
                                    ),
                                    Text(
                                      items.customerFinId??'',
                                      style: AppStyles.subHeading,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            //SizedBox(width: displayWidth(context) * 0.4),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, AppRoutes.pdformscreen,arguments: {
                                //   'customerId': items.customerId
                                // });
                                _showCustomBottomSheet(context);
                              },
                              child: Text(
                                'initiate again',
                                style: AppStyles.blueText,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                  error: (error, stackTrace) {
                  ExceptionHandler().handleError(error);
                  return
                   const Text('');} ,
                  loading: () {
                  return const Center(child: CircularProgressIndicator());
                },),
                
                constantSizedBox(context),
                // constantSizedBox(context),
                constantSizedBox(context)
      
      
              ],
            ),
          ),
        )),
      ),
    );
  }

  constantSizedBox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.015,
    );
  }

  Widget squareBox({

    required String backImage,
    required String iconImage,
    required String title,
    required String stitle,
    required BuildContext context,
    required Color titleColor,
    required Color stitleColor,
  }) {
    final gridItems = ref.watch(griditemProvider);

    return Stack(
      children: [

        GestureDetector(
          onTap: () {
            if (title == 'Approved PD') {
              Navigator.pushNamed(context, AppRoutes.pdapprove);
            } else if (title == 'Pending PD') {
              Navigator.pushNamed(context, AppRoutes.pdpending);
            } else if (title == 'Rejected PD') {
              Navigator.pushNamed(context, AppRoutes.pdreject);
            } else if (title == 'Completed PD') {
              print('Completed PD');
              Navigator.pushNamed(context, AppRoutes.pdComplete);
            }
          },
          child: Stack(
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
                    constantSizedBox(context),
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
          ),
        ),
        // Positioned(
        //     top: 0,right: 0,
        //     child: Container(
        //       height: 20,width: 20,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: AppColors.red,
        //       ),
        //       child: Text(gridItems.length.toString(),
        //         style: TextStyle(color: AppColors.white,),
        //       ),)),
      ],
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // Allow custom height
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.transparent,
      // Make background transparent to see the cross icon
      builder: (BuildContext bc) {
        return Stack(
          children: [
            // This is the bottom sheet content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                height: displayHeight(context) *
                    0.75, // Adjust height here (e.g., 75% of screen height)
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon_image.png',
                      height: displayHeight(context) * 0.1,
                      width: displayWidth(context) * 0.3,
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.04,
                    ),
                    Text(
                      'Do Customer have these 3 \n documents?',
                      textAlign: TextAlign.center,
                      style: AppStyles.TextStyle16,
                    ),
                    SizedBox(height: displayHeight(context) * 0.01),
                    Image.asset(
                      'assets/images/mesag_container.png',
                      height: displayHeight(context) * 0.3,
                      width: displayWidth(context) * 0.5,
                    ),
                    AppButton(
                      onTap: () {
                        Navigator.pop(context);
                        _showSecondBottomSheet(context);

                      },
                      textStyle: AppStyles.buttonLightTextStyle,
                      label: 'Yes, Applicant has it',
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                    SizedBox(height: displayHeight(context) * 0.02),
                    AppButton(
                      onTap: () {},
                      textStyle: AppStyles.buttonLightTextStyle,
                      label: 'No',
                      isFill: true,
                      // textStyle: AppStyles.grayStyle,
                      bgColor: const Color(0xffF4F4F4),
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ],
                ),
              ),
            ),

            // This is the cross icon above the bottom sheet
            Positioned(
              top: displayHeight(context) *
                  0.12, // You can adjust the distance from the top
              right: displayWidth(context) *
                  0.45, // Adjust the right margin for the cross icon
              child: Container(
                height: displayHeight(context) * 0.13,
                width: displayWidth(context) * 0.13,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: IconButton(
                  icon: const Icon(Icons.close, size: 30, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSecondBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // Allow custom height
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.transparent,
      // Make background transparent to see the cross icon
      builder: (BuildContext bc) {
        return Stack(
          children: [
            // This is the bottom sheet content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                height: displayHeight(context) *
                    0.6, // Adjust height here (e.g., 75% of screen height)
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Do Write your Particular reason for reject this case.',
                      style: AppStyles.TextStyle16,textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text('Remark'),
                    const SizedBox(height: 10),
                    AppFloatTextField(
                      onChange: (value) {
                        // checkpassValidation.checkPassword(value);
                      },
                      // initialValue: 'cvfcfbcvb',
                      maxLine: 1,
                      //   focusNode: focusViewModel.passFocusNode,
                      //  currentState: focusStates['passFocusNode'],
                      // height: passwordValidations
                      //     ? displayHeight(context) * 0.09
                      //     : null,
                      // focusNode: FocusNode(),
                      onValidate: (value) {
                        print(value);
                        if (value!.isEmpty) {
                          return "password is a required field";
                        }
                        return '';
                      },
                      onFiledSubmitted: (value) {
                        // ref
                        //     .read(passwordValidationProvider.notifier)
                        //     .checkPassword(value);
                      },
                      inerHint: 'enter your remark',
                      errorText: "password is a required field",
                      //    isError: passwordValidations,
                      textInputAction: TextInputAction.next,
                      isSuffix: true,

                      hint: 'enter your remark',
                      // controller: _passwordController,
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.05,
                    ),
                    AppButton(
                      onTap: () {},
                      label: 'Submit',
                      textStyle: AppStyles.buttonLightTextStyle,
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: displayHeight(context) * 0.02),
                    AppButton(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      label: 'Cancel',
                      isFill: true,
                      textStyle: AppStyles.buttonLightTextStyle,
                      bgColor: const Color(0xffF4F4F4),
                      height: displayHeight(context) * 0.06,
                      width: displayWidth(context),
                    ),
                  ],
                ),
              ),
            ),

            // This is the cross icon above the bottom sheet
            Positioned(
              top: displayHeight(context) *
                  0.28, // You can adjust the distance from the top
              right: displayWidth(context) *
                  0.45, // Adjust the right margin for the cross icon
              child: Container(
                height: displayHeight(context) * 0.13,
                width: displayWidth(context) * 0.13,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: IconButton(
                  icon: const Icon(Icons.close, size: 30, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }



}
