import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/routes/routes.dart';
import '../../../../../base/service/session_service.dart';
import '../../../../../base/utils/namespase/app_colors.dart';
import '../../../Collection cases/view_model/visit_pending_view_model.dart';
import '../../home_collection_viewmodel/fetchUserProfile.dart';

class CollectionLogoutDialogContent extends ConsumerWidget{
  const CollectionLogoutDialogContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
return  SizedBox(
  height: 110,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.zero,
            // backgroundColor: colors,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            ref.read(apiResponseProvider.notifier).clearData();
            ref.invalidate(fetchVisitPendingDataProvider);
            SessionService.deleteSession();
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) =>false,);
            ref.invalidate(apiResponseProvider);
          },
          child: const Text('Logout',
              style: TextStyle(color: AppColors.white)),
        ),
      ),
      TextButton(
        child: const Text('CANCEL',
            style: TextStyle(color: AppColors.primary)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);
  }

}