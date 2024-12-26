import 'package:finexe/feature/Eod/view_model/bodlist_viewmodel.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/font_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../AddBOD_dialogue/AddBOD_dialogue/view/add_bod._dialogue.dart';


class BODScreen extends ConsumerWidget {
  const BODScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eodControllerProvider);
    if (kDebugMode) {
      print(state.bodList);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("BOD Tasks"),
        centerTitle: true,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      itemCount: state.bodList.length + 1,
                      //  itemCount: controller.bodList.length,
                      itemBuilder: (context, index) {
                        // final task = state.bodList[index];
                        print('index $index');
                        if (index == 0) {
                          return AppButton(
                            width: 40,
                            label: 'Add BOD Task',
                            textStyle: const TextStyle(color: Colors.white),
                            onTap: () {
                              AddBodDialog().addAlbumDialog(context);

                              // controller.onTapAddButton(context);
                            },
                          );
                        }

                        return InkWell(
                          onTap: () {
                            bottomSheet(context, index - 1, ref);
                          },
                          child: Column(
                            children: [
                              Card(
                                  elevation: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: AppColors.boxBorderGray),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    // height: MediaQuery.of(context).size.height * 0.10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                state.bodList[index - 1].task,
                                                style: AppStyles
                                                    .headingTextStyle
                                                    .copyWith(
                                                        fontSize:
                                                            FontSize.fontSize16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              state.bodList[index - 1].status,
                                              style: TextStyle(
                                                  color: state
                                                              .bodList[
                                                                  index - 1]
                                                              .status
                                                              .toString() ==
                                                          'pending'
                                                      ? Colors.red
                                                      : state.bodList[index - 1]
                                                                  .status
                                                                  .toString() ==
                                                              'completed'
                                                          ? Colors.green
                                                          : Colors.orange),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                state.bodList[index - 1]
                                                    .description,
                                                style: const TextStyle(),
                                              ),
                                            ),
                                            state.bodList[index - 1]
                                                        .startDate !=
                                                    ''
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        DateFormat.yMMMd()
                                                            .format(DateFormat(
                                                                    "yyyy-MM-dd'T'h:mm:ss a")
                                                                .parse(state
                                                                    .bodList[
                                                                        index -
                                                                            1]
                                                                    .startDate)),
                                                        style:
                                                            const TextStyle(),
                                                      ),
                                                      Text(
                                                        DateFormat.jm().format(
                                                            DateFormat(
                                                                    "yyyy-MM-dd'T'h:mm:ss a")
                                                                .parse(state
                                                                    .bodList[
                                                                        index -
                                                                            1]
                                                                    .startDate)),
                                                        style:
                                                            const TextStyle(),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                        employeeDetailsText(context,
                                            heading: 'ManagerBodStatus',
                                            data: state.bodList[index - 1]
                                                .managerBodStatus),
                                      ],
                                    ),
                                  )),
                              // SizedBox(
                              //   height:
                              //       MediaQuery.of(context).size.height * 0.01,
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget employeeDetailsText(context,
      {required String heading, required String data}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: Text(
              maxLines: 2,
              '$heading:',
              style:
                  AppStyles.subTextStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Flexible(
            child: Text(
              data,
              style: AppStyles.subTextStyle.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }

  //Used unnder bottomsheet
  Widget detailsText(context, {required String heading, required String data}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Text('data'),
          Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              child: Text(
                maxLines: 2,
                '$heading:',
                style: AppStyles.subTextStyle
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
          ),
          Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              child: Text(
                data,
                style: AppStyles.subTextStyle.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> bottomSheet(BuildContext context, int index, WidgetRef ref) {
    final state = ref.watch(eodControllerProvider);

    return showModalBottomSheet<void>(
      backgroundColor: AppColors.white,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          // height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detailsText(context,
                  heading: 'Task ', data: state.bodList[index].task),
              const Divider(
                thickness: 1,
                color: AppColors.gray,
              ),
              detailsText(context,
                  heading: 'Description ',
                  data: state.bodList[index].description),
              const Divider(
                thickness: 1,
                color: AppColors.gray,
              ),
              detailsText(context,
                  heading: 'Status ', data: state.bodList[index].status),
              const Divider(
                thickness: 1,
                color: AppColors.gray,
              ),
              detailsText(context,
                  heading: 'Manager Bod Status ',
                  data: state.bodList[index].managerBodStatus),
              const Divider(
                thickness: 1,
                color: AppColors.gray,
              ),
              detailsText(context,
                  heading: 'Manager Eod Status ',
                  data: state.bodList[index].managerEodStatus),
              const Divider(
                thickness: 1,
                color: AppColors.gray,
              ),
              detailsText(context,
                  heading: 'Last Updated Time ',
                  data: DateFormat.yMMMd().add_jm().format(state
                      .bodList[index].updatedAt
                      .add(const Duration(hours: 5, minutes: 30)))),
              const Divider(
                thickness: 1,
                color: AppColors.gray,
              ),
              detailsText(context,
                  heading: 'Create Eod Time ',
                  data: DateFormat.yMMMd().add_jm().format(state
                      .bodList[index].createdAt
                      .add(const Duration(hours: 5, minutes: 30)))),
              const Divider(
                thickness: 1,
                color: AppColors.gray,
              ),
              state.bodList[index].endDate != ''
                  ? detailsText(context,
                      heading: 'End Date ',
                      data: DateFormat.yMMMd().add_jm().format(
                          DateFormat("yyyy-MM-dd'T'h:mm:ss a")
                              .parse(state.bodList[index].endDate)))
                  : detailsText(context, heading: 'End Date', data: ''),
              const Divider(
                thickness: 1,
                color: AppColors.gray,
              ),
              detailsText(context,
                  heading: 'Start Date ',
                  data: DateFormat.yMMMd().add_jm().format(
                      DateFormat("yyyy-MM-dd'T'h:mm:ss a")
                          .parse(state.bodList[index].startDate))),
            ],
          ),
        );
      },
    );
  }
}
