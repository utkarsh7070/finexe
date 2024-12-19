import 'package:cached_network_image/cached_network_image.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/ui/PD/Model/pd_complete_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../base/utils/namespase/app_colors.dart';
import '../../../base/utils/namespase/app_style.dart';
import '../../../base/utils/namespase/display_size.dart';
import '../pd_view_model/pd_completed_viewmodel.dart';

class PdCompletedScreen extends ConsumerStatefulWidget {
  const PdCompletedScreen({super.key});

  @override
  _PdCompletedScreen createState() => _PdCompletedScreen();
}

class _PdCompletedScreen extends ConsumerState<PdCompletedScreen> {
  final ScrollController _scrollController = ScrollController();
  List<CompleteItem> _data = [];
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
    final response =
        await ref.read(paginatedCompletedDataProvider(_currentPage).future);
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
    final response =
        await ref.read(paginatedCompletedDataProvider(newPage).future);
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
    // final pdrejectitems = ref.watch(pdrejectViewModel);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.white,
        ),
        backgroundColor: AppColors.white,
        title: const Text('PD Complete'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ref.read(paginatedCompletedDataProvider(_currentPage).future),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              _data.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      final items = _data[index];
                      //   return _buildApplicantDetails(context, applicant);
                      return itemCard(context, items);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  itemCard(BuildContext context, CompleteItem pdreitem) {
    return Column(
      children: [
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
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: Text(
                    pdreitem.customerFinId ?? '',
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
                    child: CachedNetworkImage(
                      imageUrl: '${Api.imageUrl}${pdreitem.customerPhoto}',
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
                          pdreitem.customerAddress ?? '',
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
