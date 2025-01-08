import 'package:advanced_search/advanced_search.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/ui/PD/Model/pd_pending_response_model.dart';
import 'package:finexe/feature/ui/PD/pd_view_model/pd_pending_viewmodel.dart';
import 'package:finexe/feature/ui/Sales/NewLone/view_model/new_loan_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/api/api.dart';
import '../Model/search_list_model.dart';
import '../dialog/RejectPDFile/rejectpd_file.dart';

class PDPendingScreen extends ConsumerStatefulWidget {
  const PDPendingScreen({super.key});

  @override
  _PDPendingScreen createState() => _PDPendingScreen();
}

class _PDPendingScreen extends ConsumerState<PDPendingScreen> {
  final ScrollController _scrollController = ScrollController();
  // final ScrollController _searchscrollController = ScrollController();

  // List<Item> _data = [];
  // List<SearchItems> _Searchdata = [];
  // List<SearchItems> _filteredSearchData = [];

  int _currentPage = 1;
  // int _searchcurrentPage = 1;
  // bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _fetchInitialData();
     
      // _searchscrollController.addListener(_scrollSearchListener);
      // _fetchSearchInitialData();
      // Listen to changes in the search input
      // ref.listen<String>(serchInputProvider, (previous, current) {
      //   _filterSearchResults(current);
      // });
    // });
  }

  // Future<void> _fetchInitialData() async {
  //   final response = await ref.read(paginatedDataProvider(_currentPage).future);
  //   setState(() {
  //     _data = response ?? [];
  //   });
  // }

  // Future<void> _fetchSearchInitialData() async {
  //   final response = await ref.read(searchPaginationDataProvider(_searchcurrentPage).future);
  //   setState(() {
  //     _Searchdata  = response ?? [];
  //     _filteredSearchData = _Searchdata;
  //     print('_filteredSearchData: ${_filteredSearchData.length}');
  //   });
  // }

  // Future<void> _loadMore() async {
  //   if (_isLoadingMore) return;
  //   setState(() {
  //     _isLoadingMore = true;
  //   });
  //   final newPage = _currentPage + 1;
  //   final response = await ref.read(paginatedDataProvider(newPage).future);
  //   setState(() {
  //     _data.addAll(response ?? []);
  //     _currentPage = newPage;
  //     _isLoadingMore = false;
  //   });
  // }

  // Future<void> _loadMoreSearch() async {
  //   if (_isLoadingMore) return;
  //   setState(() {
  //     _isLoadingMore = true;
  //   });
  //   final newPage = _searchcurrentPage + 1;
  //   final response = await ref.read(searchPaginationDataProvider(newPage).future);
  //   if (response.isNotEmpty) {
  //     setState(() {
  //       _Searchdata.addAll(response ?? []);
  //       _searchcurrentPage = newPage;
  //       _isLoadingMore = false;
  //     });
  //   }
  // }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent
        ) {
       ref.read(paginatedDataProvider(_currentPage+1));
    }
  }
  // void _scrollSearchListener() {
  //   if (_searchscrollController.position.pixels ==
  //       _searchscrollController.position.maxScrollExtent &&
  //       !_isLoadingMore) {
  //     _loadMoreSearch();
  //   }
  // }

  // void _filterSearchResults(String query) {
  //   if (query.isEmpty) {
  //     setState(() {
  //       _filteredSearchData = _Searchdata; // Show all items if the query is empty
  //     });
  //   } else {
  //     setState(() {
  //       _filteredSearchData = _Searchdata
  //           .where((item) => item.customerName
  //           .toLowerCase()
  //           .contains(query.toLowerCase()))
  //           .toList();
  //     });
  //   }
  // }
  // bool _isListening = false;
  @override
  Widget build(BuildContext context) {
     _scrollController.addListener(_scrollListener);
    // print('_Searchdata:: ${_Searchdata.length}');
    // if (!_isListening) {
    //   print('_isListening:: $_isListening');
    //   ref.listen<String>(serchInputProvider, (previous, current) {
    //     _filterSearchResults(current);
    //   });
    //   _isListening = true;
    // }
    // updated
    final paginatedData = ref.watch(paginatedDataProvider(_currentPage));
    final searcheddata = ref.watch(searchingitems);
    
   

    // final applicants = ref.watch(applicantProvider);
    // final asyncData = ref.watch(paginatedDataProvider);
    return NetworkListener(
      context: context,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            flexibleSpace: Container(
              color: Colors.white,
            ),
            backgroundColor: AppColors.white,
            title: const Text('PD Pending'),
            centerTitle: true,
          ),
          body: paginatedData.when(
            data: (paginateddata) {
              return RefreshIndicator(
                onRefresh: () async {
                  print('ug');
                  searcheddata.clear();
                  ref.refresh(paginatedDataProvider(_currentPage));
                  

                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AdvancedSearch(
                        maxElementsToDisplay: 0,
                        singleItemHeight: 50,
                        borderColor: Colors.grey,
                        minLettersForSearch: 0,
                        selectedTextColor: const Color(0xFF3363D9),
                        fontSize: 14,
                        borderRadius: 12.0,
                        hintText: 'Search here',
                        cursorColor: Colors.blueGrey,
                        autoCorrect: false,
                        focusedBorderColor: Colors.blue,
                        searchResultsBgColor: const Color(0x00fafafa),
                        disabledBorderColor: Colors.cyan,
                        enabledBorderColor: Colors.black,
                        enabled: true,
                        caseSensitive: false,
                        inputTextFieldBgColor: Colors.white10,
                        clearSearchEnabled: true,
                        itemsShownAtStart: 1,
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
                          FocusManager.instance.primaryFocus!.unfocus();
                          if (kDebugMode) {
                            print("Cleared Search");
                          }
                        },
                        onSubmitted: (searchText, listOfResults) {
                          searchupdate(ref, searchText, paginateddata);
                        },
                        onEditingProgress: (searchText, listOfResults) {
                          searchupdate(ref, searchText, paginateddata);
                        },
                        searchItems: [],
                      ),
                    ),
                    Expanded(
                      // height: displayHeight(context) * 0.8, // Adjust height as needed
                      child: ListView.builder(
                        // padding:
                        //     EdgeInsets.only(top: displayHeight(context) * 0.0),
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: searcheddata.length,
                        itemBuilder: (context, index) {
                          final applicant = searcheddata[index];
                                                    print('photo'+applicant.customerPhoto.toString());

                          return _buildApplicantDetails(context, applicant);
                        },
                      ),
                    ),
                    // Positioned(
                    //   child: Column(
                    //     children: [
                    //       if (paginateddata.isEmpty)
                    //         Container(
                    //           margin: EdgeInsets.only(
                    //             top: displayHeight(context) * 0.1,
                    //             left: displayWidth(context) * 0.35,
                    //           ),
                    //           child: const Text('No Data available'),
                    //         )
                    //       else
                    // SizedBox(
                    //   height: displayHeight(context) * 0.8, // Adjust height as needed
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.only(top: displayHeight(context) * 0.08),
                    //     controller: _scrollController,
                    //     shrinkWrap: true,
                    //     physics: const AlwaysScrollableScrollPhysics(),
                    //     scrollDirection: Axis.vertical,
                    //     itemCount: paginateddata.length,
                    //     itemBuilder: (context, index) {
                    //       final applicant = paginateddata[index];
                    //       return _buildApplicantDetails(context, applicant);
                    //     },
                    //   ),
                    // ),
                    //     ],
                    //   ),
                    // ),
                    // Positioned(
                    //   child: Container(
                    //     color: Colors.white,
                    //     margin: const EdgeInsets.symmetric(horizontal: 20),
                    //     child: AdvancedSearch(
                    //       maxElementsToDisplay: 10,
                    //       singleItemHeight: displayHeight(context) * 0.28,
                    //       borderColor: Colors.grey,
                    //       minLettersForSearch: 1,
                    //       selectedTextColor: const Color(0xFF3363D9),
                    //       fontSize: 14,
                    //       borderRadius: 12.0,
                    //       hintText: 'Search Me',
                    //       cursorColor: Colors.blueGrey,
                    //       autoCorrect: false,
                    //       focusedBorderColor: Colors.blue,
                    //       searchResultsBgColor: const Color(0x00fafafa),
                    //       disabledBorderColor: Colors.cyan,
                    //       enabledBorderColor: Colors.black,
                    //       enabled: true,
                    //       caseSensitive: false,
                    //       inputTextFieldBgColor: Colors.white10,
                    //       clearSearchEnabled: true,
                    //       itemsShownAtStart: 10,
                    //       searchMode: SearchMode.CONTAINS,
                    //       showListOfResults: true,
                    //       unSelectedTextColor: Colors.black54,
                    //       hideHintOnTextInputFocus: true,
                    //       hintTextColor: Colors.grey,
                    //       onItemTap: (index, searchText) {
                    //         ref.read(serchInputProvider.notifier).state = searchText;
                    //         ref.read(searchPaginationDataProvider(_searchcurrentPage).future);
                    //       },
                    //       onEditingProgress: (searchText, listOfResults) {
                    //         ref.read(serchInputProvider.notifier).state = searchText;

                    //         setState(() {
                    //           _Searchdata = _filteredSearchData
                    //               .where((item) => item.customerName
                    //               .toLowerCase()
                    //               .contains(searchText.toLowerCase()))
                    //               .toList();
                    //         });

                    //         ref.read(searchPaginationDataProvider(_searchcurrentPage).future);
                    //       },
                    //       searchItems: _Searchdata.map((item) => item.customerName).toList(),
                    //       searchItemsWidget: (p0) {
                    //         return ListView.builder(
                    //           controller: _searchscrollController,
                    //           shrinkWrap: true,
                    //           physics: const AlwaysScrollableScrollPhysics(),
                    //           scrollDirection: Axis.vertical,
                    //           itemCount: _Searchdata.length,
                    //           itemBuilder: (context, index) {
                    //             final searchData = _Searchdata[index];
                    //             return _buildSearchDetails(context, searchData);
                    //           },
                    //         );
                    //       },
                    //       onSearchClear: () {
                    //         ref.read(serchInputProvider.notifier).state = '';
                    //         setState(() {
                    //           _Searchdata.clear();
                    //           _searchcurrentPage = 1;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) {
              debugPrint('Error loading collection details: $error');
              return const Text('Error loading collection details');
            },
            loading: () {
              debugPrint('Collection data loading...');
              return const Center(child: CircularProgressIndicator());
            },
          )

          //  FutureBuilder<List<Item>>(
          //   future: ref.read(paginatedDataProvider(_currentPage).future),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting && _data.isEmpty) {
          //       return const Center(child: CircularProgressIndicator());
          //     } else if (snapshot.hasError) {
          //       return Center(child: Text('Error: ${snapshot.error}'));
          //     } else {

          //     }
          //   },
          // ),
          ),
    );
  }

  Widget _buildApplicantDetails(BuildContext context, Item applicant) {
    return Column(
      children: [
        // applicant.date == null || applicant.date!.isEmpty
        //     ? SizedBox.shrink()
        //     :
        // Container(
        //         alignment: Alignment.centerLeft,
        //         margin: EdgeInsets.only(top: displayHeight(context) * 0.03),
        //         padding: EdgeInsets.only(left: displayWidth(context) * 0.05),
        //         child: Text(
        //           applicant.date!,
        //           textAlign: TextAlign.left,
        //           style: AppStyles.gray7Text,
        //         ),
        //       ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: displayWidth(context) * 0.05,
            vertical: displayHeight(context) * 0.01,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.dividerColor, width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ExpansionTile(
            // minTileHeight: displayHeight(context) * 0.01,
            childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
            shape: const Border(
              bottom: BorderSide(color: AppColors.dividerColor),
            ),
            title: Container(
              height: displayHeight(context) * 0.06,
              decoration: const BoxDecoration(color: Colors.white),
              margin: EdgeInsets.only(top: displayHeight(context) * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: displayHeight(context) * 0.09,
                          width: displayWidth(context) * 0.12,
                          fit: BoxFit.cover,
                          imageUrl:
                          // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-C_UAhXq9GfuGO452EEzfbKnh1viQB9EDBQ&s',
                              '${Api.baseUrl}${applicant.customerPhoto}',
                              placeholder: (context, url) => Center(child: const CircularProgressIndicator()),
                              errorWidget: (context, url, error){
                              
                                return 
                                const Icon(Icons.error);} ,
                        ),
                      ),
                      SizedBox(width: displayWidth(context) * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(applicant.customerName ?? '',
                              style: AppStyles.blacktext14),
                          Text(applicant.customerFinId ?? '',
                              style: AppStyles.subHeading),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Address',
                        textAlign: TextAlign.left, style: AppStyles.gray7Text),
                    Text(applicant.customerAddress ?? '',
                        style: AppStyles.subTextStyle),
                  ],
                ),
              ),
              SizedBox(height: displayHeight(context) * 0.01),
              // constSizedbox(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Refuse PD
                  GestureDetector(
                    onTap: () {
                      // PdRivertDialogue.requestRivertDialogue(context: context, id: pdreitem.sId?? '',
                      //     ref: ref );
                      PdRijectDialogue.requestRijectDialogue(
                          context: context,
                          customerID: applicant.customerId ?? '');
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: 44,
                      width: displayWidth(context) * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.red
                          // border: Border.all(color: AppColors.red, width: 1.5)
                          ),
                      child: const Text(
                        'Reject',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        // style: AppStyles.whiteText16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.pdformscreen,
                          arguments: applicant.customerId);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: 44,
                      width: displayWidth(context) * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.primary
                          // border:
                          // Border.all(color: AppColors.primary, width: 1.5)
                          ),
                      child: const Text(
                        'Resume',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  // SizedBox(width: displayWidth(context)*0.2,),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildSearchDetails(BuildContext context,SearchItems searchUsers) {
  //   return Column(
  //     children: [
  //       // applicant.date == null || applicant.date!.isEmpty
  //       //     ? SizedBox.shrink()
  //       //     :
  //       // Container(
  //       //         alignment: Alignment.centerLeft,
  //       //         margin: EdgeInsets.only(top: displayHeight(context) * 0.03),
  //       //         padding: EdgeInsets.only(left: displayWidth(context) * 0.05),
  //       //         child: Text(
  //       //           applicant.date!,
  //       //           textAlign: TextAlign.left,
  //       //           style: AppStyles.gray7Text,
  //       //         ),
  //       //       ),
  //       Container(
  //         margin: EdgeInsets.symmetric(
  //           horizontal: displayWidth(context) * 0.05,
  //           vertical: displayHeight(context) * 0.01,
  //         ),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           border: Border.all(color: AppColors.dividerColor, width: 1.0),
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: ExpansionTile(
  //           // minTileHeight: displayHeight(context) * 0.01,
  //           childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
  //           shape: const Border(
  //             bottom: BorderSide(color: AppColors.dividerColor),
  //           ),
  //           title: Container(
  //             height: displayHeight(context) * 0.06,
  //             decoration: const BoxDecoration(color: Colors.white),
  //             margin: EdgeInsets.only(top: displayHeight(context) * 0.02),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     ClipRRect(
  //                       borderRadius: BorderRadius.circular(10),
  //                       child: CachedNetworkImage(
  //                         height: displayHeight(context) * 0.09,
  //                         width: displayWidth(context) * 0.12,
  //                         fit: BoxFit.cover,
  //                         imageUrl:
  //                         '${Api.baseUrl}${searchUsers.customerPhoto}' ?? '',
  //                       ),
  //                     ),
  //                     SizedBox(width: displayWidth(context) * 0.03),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(searchUsers.customerName ?? '',
  //                             style: AppStyles.blacktext14),
  //                         Text(searchUsers.customerFinId ?? '',
  //                             style: AppStyles.subHeading),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           children: <Widget>[
  //             Container(
  //               padding: const EdgeInsets.only(right: 10),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('Address',
  //                       textAlign: TextAlign.left, style: AppStyles.gray7Text),
  //                   Text(searchUsers.customerAddress ?? '',
  //                       style: AppStyles.blacktext14),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: displayHeight(context) * 0.01),
  //             Container(
  //               margin: EdgeInsets.only(right: displayWidth(context) * 0.05),
  //               child: AppButton(
  //                 onTap: () {
  //                   Navigator.pushNamed(context, AppRoutes.pdformscreen,arguments: searchUsers.customerId);
  //                   // _showCustomBottomSheet(context);
  //                 },

  //                 label: 'Resume',
  //                 isFill: true,
  //                 textStyle:
  //                 AppStyles.grayStyle.copyWith(color: AppColors.white),
  //                 // bgColor: AppColors.buttongray,
  //                 bgColor: const Color(0xffF4F4F4),
  //                 height: MediaQuery.of(context).size.height * 0.06,
  //                 width: MediaQuery.of(context).size.width * 0.8,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
