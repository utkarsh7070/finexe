import 'package:finexe/feature/Eod/view_model/bodlist_viewmodel.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EODScreenAdd extends ConsumerWidget {
  const EODScreenAdd({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eodControllerProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text("Update BOD Task"),
          centerTitle: true,
        ),
        body: state.isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.bodList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(
                                elevation: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: AppColors.boxBorderGray)),
                                  padding: const EdgeInsets.all(16),
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Task:- ',
                                                style: AppStyles.subTextStyle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: state
                                                        .bodList[index].task,
                                                    style: AppStyles
                                                        .subTextStyle
                                                        .copyWith(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Flexible(
                                          //     child: Text(
                                          //   style:
                                          //       AppStyles.subTextStyle.copyWith(
                                          //     overflow: TextOverflow.ellipsis,
                                          //   ),
                                          //   'Task:- ${controller.bodList[index].task}',
                                          //   maxLines: 2,
                                          // )),
                                          Visibility(
                                            replacement: const Text(
                                              'Completed',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                            visible:
                                                state.dropDownValue[index] !=
                                                    'Completed',
                                            child: DropdownButton<String>(
                                              underline: const SizedBox(),
                                              value: state.dropDownValue[index],
                                              elevation: 16,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              onChanged: (String? value) {
                                                if (value != null) {
                                                  ref
                                                      .read(
                                                          eodControllerProvider
                                                              .notifier)
                                                      .changeDropdown(
                                                        value,
                                                        index,
                                                        state.bodList[index].id,
                                                        context,
                                                      );
                                                }
                                              },
                                              items: ref
                                                  .read(eodControllerProvider
                                                      .notifier)
                                                  .dropDownItem(),
                                            ),
                                          )
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: MediaQuery
                                      //       .of(context)
                                      //       .size
                                      //       .height * 0.01,
                                      // ),
                                      Flexible(
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Description:- ',
                                            style: AppStyles.subTextStyle
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: state
                                                    .bodList[index].description,
                                                style: AppStyles.subTextStyle
                                                    .copyWith(
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Flexible(
                                      //   child: Text(
                                      //     style: AppStyles.subTextStyle.copyWith(
                                      //       overflow: TextOverflow.ellipsis,
                                      //     ),
                                      //     'Description:- ${controller.bodList[index].description}',
                                      //     maxLines: 5,
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      employeeDetailsText(
                                        context,
                                        heading: 'Updated EOD',
                                        data: DateFormat.yMMMd()
                                            .add_jm()
                                            .format(state
                                                .bodList[index].updatedAt
                                                .add(const Duration(
                                                    hours: 5, minutes: 30))),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      employeeDetailsText(context,
                                          heading: 'Manager Eod Status',
                                          data: state
                                              .bodList[index].managerEodStatus,
                                          color: state.bodList[index]
                                                      .managerEodStatus
                                                      .toString() ==
                                                  'pending'
                                              ? Colors.red
                                              : state.bodList[index]
                                                          .managerEodStatus
                                                          .toString() ==
                                                      'completed'
                                                  ? Colors.green
                                                  : Colors.orange),
                                    ],
                                  ),
                                )),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.01,
                            // ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ));
  }

  Widget employeeDetailsText(context,
      {required String heading, required String data, Color? color}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Flexible(
            child: Text(
              '$heading:',
              style:
                  AppStyles.subTextStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
          ),
          Flexible(
            child: Text(
              data,
              style: AppStyles.subTextStyle
                  .copyWith(overflow: TextOverflow.ellipsis, color: color),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
