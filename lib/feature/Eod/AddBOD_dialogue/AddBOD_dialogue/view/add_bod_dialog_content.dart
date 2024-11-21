import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../../../../base/utils/widget/app_text_field.dart';

class AddBodContent extends ConsumerWidget {
  const AddBodContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final punchViewModel = ref.read(attendanceProvider.notifier);
    final punchStateModel = ref.watch(attendanceProvider);
    return Column(
      children: [
        SizedBox(
          // height: MediaQuery.of(context).size.height * 0.20,
          // width: MediaQuery.of(context).size.width * 0.70,
          child: Column(
            children: [
              const Text('Add Task'),
              SizedBox(height: displayHeight(context)*0.01,),
              AppTextField(
                onChange: (value) {
                  punchViewModel.updateTaskTitle(value);
                },
                textInputType: TextInputType.text,
                hint: 'Enter Task Title',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: AppTextField(
                  maximumLines: 5,
                  onChange: (value) {
                    punchViewModel.updateTaskDescription(value);
                  },
                  textInputType: TextInputType.text,
                  hint: 'Enter Task Description',
                ),
              ),
            ],
          ),
        ),
        TextButton(
          child: const Text('ADD today tasks'),
          onPressed: () async {
              await punchViewModel.onAddTask(context).then(
                (value) {
                  print('refreshing list ');
                  // ref.refresh(eodControllerProvider);
                },
              );
              // showCustomSnackBar(context, 'Please Add Task', AppColors.red);
          },
        ),
      ],
    );
  }
}
