import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Model/pd_request_list_model.dart';
import 'package:finexe/feature/ui/PD/pd_view_model/pd_request_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/utils/widget/app_button.dart';
import '../dialog/AcceptPDFile/pd_request_dialog.dart';

class PdRequestScreen extends ConsumerStatefulWidget {
  const PdRequestScreen({super.key});

  @override
  _PdRequestScreen createState() => _PdRequestScreen();
}

class _PdRequestScreen extends ConsumerState<PdRequestScreen> {
  final ScrollController _scrollController = ScrollController();
  List<PDReqItems> _data = [];
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
      _scrollController.addListener(_scrollListener);
    });
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;
    setState(() {
      _isLoadingMore = true;
    });
    final newPage = _currentPage + 1;
    final response = await ref.read(fetchpdRefuseandAcceptListProvider(
            ArgumentModel(
                page: newPage,
                branchId: 'all',
                currentPage: 0,
                filter: '',
                pageSize: 0))
        .future);
    setState(() {
      _data.addAll(response ?? []);
      _currentPage = newPage;
      _isLoadingMore = false;
    });
  }

  Future<void> _fetchInitialData() async {
    final response = await ref.read(fetchpdRefuseandAcceptListProvider(
            ArgumentModel(page: _currentPage, branchId: 'all', currentPage: 0,filter: '',pageSize: 0))
        .future);
    setState(() {
      _data = response ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // final page = ref.watch(paginationPageNo);
    final pdRequestViewModel = ref.watch(pdRequestProvider);
    final itemViewModel = ref.read(itemViewModelProvider.notifier);
    // final selectedState =  ref.watch(selectedValue);
    // final selected =  ref.read(selectedValue.notifier);
    // final dataListProvider = ref.watch(dataList);

    return NetworkListener(
      context: context,
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              color: Colors.white,
            ),
            backgroundColor: AppColors.white,
            title: const Text('PD Request'),
            centerTitle: true,
          ),
          body: Padding(
            
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                DropDownTextField(
                  onChanged: (dropDown) {
                    if (dropDown != null) {
                      print('drop down $dropDown');
                      // paymentViewModel.openFeilds(dropDown.value);
                    }
                  },
                  clearOption: false,
                  controller: itemViewModel.creditPersonController,
                  listSpace: 20,
                  listPadding: ListPadding(top: 20),
                  enableSearch: false,
                  dropDownList: dropdownOptions,
                  listTextStyle:
                  const TextStyle(color: AppColors.primary),
                  // dropDownItemCount: data.length,
                  // textFieldFocusNode:
                  // paymentFocusViewModel.modeOfCollection,
                  textFieldDecoration: const InputDecoration(
                    hintStyle: TextStyle(color: AppColors.textGray),
                    // floatingLabelStyle:
                    // paymentFocusStates['modeOfCollection']!
                    //     ? AppStyles.subHeading
                    //     .copyWith(color: AppColors.primary)
                    //     : AppStyles.subHeading,
                    label: Text(
                      'Select Branch',
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.buttonBorderGray, width: 1),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    // filled: true,
                    // fillColor: AppColors.gray,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.buttonBorderGray, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
            
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.blue, width: 2),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: displayHeight(context)*0.04,),
                Expanded(
                  child: FutureBuilder(
                    future: ref.read(fetchpdRefuseandAcceptListProvider(
                            ArgumentModel(page: _currentPage, branchId: 'all',pageSize: 0,filter: '',currentPage: 0))
                        .future),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          _data.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Not found Data'));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return ListView.builder(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: _data.length,
                          itemBuilder: (context, index) {
                            final applicant = _data[index];
                            return itemCard(
                                context, applicant, pdRequestViewModel, ref);
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )

          // pditems.when(
          //   data: (pdDataItems) {
          //     return Column(
          //       children: [
          //         // Text('data'),
          //         Expanded(
          //           child:
          //               // pditems == null // Check for loading state
          //               //     ? Center(child: CircularProgressIndicator())
          //               //     :
          //               pditems.value!.isEmpty // Check for empty state
          //                   ? const Center(
          //                       child: Text(
          //                         'No PD Requests found',
          //                         style:
          //                             TextStyle(fontSize: 16, color: Colors.grey),
          //                       ),
          //                     )
          //                   :
          //                   ListView.builder(
          //                       controller: _scrollController,
          //                       physics: const AlwaysScrollableScrollPhysics(),
          //                       itemCount: pdDataItems.length,
          //                       itemBuilder: (context, index) {
          //                         final applicant = pdDataItems[index];
          //                         return itemCard(context, applicant,
          //                             pdRequestViewModel, ref);
          //                       },
          //                     ),
          //         ),
          //       ],
          //     );
          //   },
          //   loading: () => const Center(child: CircularProgressIndicator()),
          //   error: (error, stackTrace) => Center(child: Text('Error: $error')),
          //   // error: (error, stackTrace) {
          //   //   print('Error: $error');
          //   //   return Center(
          //   //     child: Text('Data not found'),
          //   //   );
          //   // },
          // )
          ),
    );
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
                          pdreitem.customerName ?? '',
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
                          pdreitem.customerAddress ?? 'NA',
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
              AppButton(
                width: displayWidth(context) * 0.80,
                bgColor: AppColors.white,
                isBorderColor: true,
                borderColor: AppColors.primary,
                label: 'Accept',
                onTap: () {
                  PdRequestDialogue.requestAcceptDialogue(
                      context: context, id: pdreitem.sId ?? '');
                },
              ),
              // GestureDetector(
              //   onTap: () {
              //     PdRequestDialogue.requestAcceptDialogue(
              //         context: context, id: pdreitem.sId ?? '');
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.only(top: 10),
              //     height: 44,
              //     width: displayWidth(context) * 0.3,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(30),
              //         border:
              //             Border.all(color: AppColors.primary, width: 1.5)),
              //     child: const Text(
              //       'Accept',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(color: AppColors.primary),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
