import 'package:finexe/feature/Eod/view_model/bodlist_viewmodel.dart';
import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class GetAllTask extends ConsumerWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eodControllerProvider);

    return NetworkListener(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All task"),
          centerTitle: true,
        ),
        body: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.80,
                        child: ListView.builder(
                          itemCount: state.bodFilterList.length,
                          itemBuilder: (context, index) {
                            String? formattedDate;
                            if (state.bodFilterList[index].endDate != '') {
                              DateTime dateTime =
                                  DateFormat("yyyy-MM-dd'T'h:mm:ss a")
                                      .parse(state.bodFilterList[index].endDate);
                              formattedDate = DateFormat.yMMMd().format(dateTime);
                            }
                            return Column(
                              children: [
                                Card(
                                    elevation: 0,
                                    color: AppColors.boxBagGray,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                              color: AppColors.boxBorderGray)),
                                      padding: const EdgeInsets.all(16),
                                      // height: MediaQuery.of(context).size.height * 0.18,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          employeeDetailsText(
                                            context,
                                            data: state.bodFilterList[index].task,
                                            heading: 'Task',
                                          ),
                                          // Text('Task:- ${controller.bodFilterList[index].task}'),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          employeeDetailsText(
                                            context,
                                            data: state
                                                .bodFilterList[index].description,
                                            heading: 'Description',
                                          ),
                                          //  Text(
                                          //    'Description:- ${controller.bodFilterList[index].description}',
                                          //   style: TextStyle(),
                                          // ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          employeeDetailsText(
                                            context,
                                            data:
                                                state.bodFilterList[index].status,
                                            heading: 'Status',
                                          ),
                                          //  Text(
                                          //   'Status:- ${controller.bodFilterList[index].status}',
                                          //   style: TextStyle(),
                                          // ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          state.bodFilterList[index].endDate != ''
                                              ? employeeDetailsText(
                                                  context,
                                                  data: ' $formattedDate',
                                                  heading: 'Date',
                                                )
                                              : const SizedBox(),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          employeeDetailsText(
                                            context,
                                            data: state.bodFilterList[index]
                                                .managerBodStatus,
                                            heading: 'ManagerBodStatus',
                                          )
      
                                          // AppTextField(
                                          //   controller: controller.passwordController,
                                          //   hint: 'Task',
                                          //   onChange: controller.onChangedPassword,
                                          //   isError: controller.validatePassword==true,
                                          //   textInputAction: TextInputAction.next,
                                          //   textInputType: TextInputType.visiblePassword,
                                          //   isSuffix: true,
                                          //   obscureText: controller.isSuffixPasswordTab,
                                          //   suffixIcon: controller.isSuffixPasswordTab
                                          //       ? CupertinoIcons.eye_slash_fill
                                          //       : Icons.remove_red_eye_rounded,
                                          //   suffixOnTap: () {
                                          //     controller.isSuffixIconTab();
                                          //   },
                                          // ),
                                        ],
                                      ),
                                    )),
                                // SizedBox(
                                //   height: MediaQuery.of(context).size.height * 0.01,
                                // )
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget employeeDetailsText(context,
      {required String heading, required String data}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Text(
            '$heading:',
            style: AppStyles.subTextStyle.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
          ),
          Flexible(
            child: Text(
              data,
              style: AppStyles.subTextStyle.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
