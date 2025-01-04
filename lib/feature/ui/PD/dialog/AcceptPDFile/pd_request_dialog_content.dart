import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../../pd_view_model/pd_dash_viewmodel.dart';
import '../../pd_view_model/pd_request_viewmodel.dart';

class PdRequestDialogContent extends ConsumerWidget{
  final String id;
  const PdRequestDialogContent({super.key,required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdRequestViewModel = ref.watch(pdRequestProvider);

    return  Column(
      children: [
        SizedBox(
          width: displayWidth(context) * 0.8,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              padding: EdgeInsets.zero,
              // backgroundColor: colors,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              if (kDebugMode) {
                print('accept PD');
              }
              pdRequestViewModel.pdRequestAccept(id,context).then((value) {
                if(value!) {
                  ref.refresh(fetchpdRefuseandAcceptListProvider);
                  ref.refresh(fetchPdRequestListProvider);
                  showCustomSnackBar(context, 'Request Accepted', AppColors.green);
                }
                Navigator.of(context).pop();
              },);

              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   AppRoutes.pdscreen, // Name of your login route
              //       (route) =>
              //   false, // Remove all routes until the login route
              // );
            },
            child: const Text('Accept',
                style: TextStyle(color: AppColors.primary)),
          ),
        ),
        SizedBox(
          height: displayHeight(context) * 0.01,
        ),
        SizedBox(
          width: displayWidth(context) * 0.8,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              // backgroundColor: colors,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
            Navigator.pop(context);
            },
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.gray)),
          ),
        ),
      ],
    );
  }

}