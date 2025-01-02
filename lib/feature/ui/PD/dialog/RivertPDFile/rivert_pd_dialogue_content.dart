import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../../Common Widgets/common_textfield.dart';
import '../../pd_view_model/pd_dash_viewmodel.dart';
import '../../pd_view_model/pd_request_viewmodel.dart';

class PdRivertDialogContent extends ConsumerStatefulWidget {
  final String id;

  const PdRivertDialogContent({super.key, required this.id});

  @override
  _PdRivertDialogContentState createState() => _PdRivertDialogContentState();
}

class _PdRivertDialogContentState extends ConsumerState<PdRivertDialogContent> {
  late TextEditingController reasonOfRivertController;

  @override
  void initState() {
    super.initState();
    reasonOfRivertController = TextEditingController();
  }

  @override
  void dispose() {
    reasonOfRivertController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pdRequestViewModel = ref.watch(pdRequestProvider);
    print('customer id of revertPDFile:: ${widget.id}');

    return  Column(
      children: [

        CustomTextFormField(
          controller: reasonOfRivertController,
          width: displayWidth(context),
          inerHint: 'Reason of Rivert',
          maxLine: 5
        ),
        SizedBox(
          height: displayHeight(context) * 0.02,
        ),
        SizedBox(
          width: displayWidth(context) * 0.8,
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

              if(reasonOfRivertController.text.isEmpty){
                showCustomSnackBar(context, 'Please enter reason of rivert request', AppColors.red);
              }else{

                pdRequestViewModel.pdRequestRevert(widget.id,reasonOfRivertController.text,context).then((value) {
                  if(value!) {
                    ref.refresh(fetchpdRefuseandAcceptListProvider);
                    ref.refresh(fetchPdRequestListProvider);
                    ref.refresh(fetchPdRefuseCasetProvider);
                    showCustomSnackBar(context, 'Rivert Request Sent Succesfully', AppColors.green);

                  }
                  Navigator.of(context).pop();
                },);
              }
            },
            child: const Text('Rivert',
                style: TextStyle(color: AppColors.white)),
          ),
        ),
        SizedBox(
          height: displayHeight(context) * 0.002,
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
              // reasonOfRivert.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.black2)),
          ),
        ),
      ],
    );
  }

}

