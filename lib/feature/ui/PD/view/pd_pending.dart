import 'package:cached_network_image/cached_network_image.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/ui/PD/Model/pd_pending_response_model.dart';
import 'package:finexe/feature/ui/PD/pd_view_model/pd_pending_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/api/api.dart';

class PDPendingScreen extends ConsumerStatefulWidget {
  const PDPendingScreen({super.key});

  @override
  _PDPendingScreen createState() => _PDPendingScreen();
}

class _PDPendingScreen extends ConsumerState<PDPendingScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Item> _data = [];
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
      _scrollController.addListener(_scrollListener);
    });
  }

  Future<void> _fetchInitialData() async {
    final response = await ref.read(paginatedDataProvider(_currentPage).future);
    setState(() {
      _data = response ?? [];
    });
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;
    setState(() {
      _isLoadingMore = true;
    });
    final newPage = _currentPage + 1;
    final response = await ref.read(paginatedDataProvider(newPage).future);
    setState(() {
      _data.addAll(response ?? []);
      _currentPage = newPage;
      _isLoadingMore = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      _loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final applicants = ref.watch(applicantProvider);
    // final asyncData = ref.watch(paginatedDataProvider);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            color: Colors.white,
          ),
          backgroundColor: AppColors.white,
          title: const Text('PD Pending'),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Item>>(
            future: ref.read(paginatedDataProvider(_currentPage).future),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  _data.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return RefreshIndicator(
                  onRefresh: _fetchInitialData,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: _data.length,
                          itemBuilder: (context, index) {
                            final applicant = _data[index];
                            return _buildApplicantDetails(context, applicant);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
            // onNotification: (scrollInfo) {
            //   if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            //     ref.read(currentPageProvider.notifier).state++;
            //     ref.refresh(paginatedDataProvider);
            //   }
            //   return false;
            // },

            ));
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
                              '${Api.baseUrl}${applicant.customerPhoto}' ?? '',
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
                        style: AppStyles.blacktext14),
                  ],
                ),
              ),
              SizedBox(height: displayHeight(context) * 0.01),
              Container(
                margin: EdgeInsets.only(right: displayWidth(context) * 0.05),
                child: AppButton(
                  onTap: () {
                    _showCustomBottomSheet(context);
                  },

                  label: 'Resume',
                  isFill: true,
                  textStyle:
                      AppStyles.grayStyle.copyWith(color: AppColors.white),
                  // bgColor: AppColors.buttongray,
                  bgColor: const Color(0xffF4F4F4),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ],
          ),
        ),
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
