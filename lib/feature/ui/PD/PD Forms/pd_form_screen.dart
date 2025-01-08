import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_existing_data/view/pd_existing_data_form.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_update_data_form.dart';
import 'package:flutter/Material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pd_view_model/pd_form_viewmodel.dart';

// import '../../pd_view_model/pd_form_viewmodel.dart';

class PdFormScreen extends ConsumerStatefulWidget {
  final String customerId;

  const PdFormScreen({super.key, required this.customerId});

  @override
  ConsumerState<PdFormScreen> createState() => _PdFormScreenState();
}

class _PdFormScreenState extends ConsumerState<PdFormScreen> {
  @override
  void initState() {
    super.initState();

    // Reset the selectedSegment to 1 when the screen is initialized
    final segmentNotifier = ref.read(segmentProvider.notifier);
    segmentNotifier.updateSegment(1);
  }

  @override
  Widget build(BuildContext context) {
    print('customerId in PdFormScreen:: ${widget.customerId}');
    final selectedSegment =
        ref.watch(segmentProvider); // Watch the selected segment
    final segmentNotifier = ref.read(segmentProvider.notifier);
    print('selectedSegment:: $selectedSegment');
    // Reset the state to default

    return NetworkListener(
      context: context,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: Container(
            color: AppColors.white,
          ),
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text("Customer Detail's"),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.w700, fontSize: 19, color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomSlidingSegmentedControl(
                  fixedWidth: MediaQuery.of(context).size.width * 0.45,
                  //  initialValue: customerState.selectedSegment,
                  children: const {
                    1: Text('Existing Data'),
                    2: Text('Update Data'),
                  },
                  decoration: BoxDecoration(
                    color: const Color(0xFFD3D3D3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                        offset: const Offset(
                          0.0,
                          2.0,
                        ),
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInToLinear,
                  onValueChanged: (value) {
                    segmentNotifier.updateSegment(value);
                    print("Segment changed to: $value");
                  },
                ),
              ),
              // const SizedBox(height: 10),
              Expanded(
                child: selectedSegment == 1
                    ? PdFilledForm(
                        customerId: widget.customerId) // Show Existing Data
                    : UpdateDataDorm(
                        customerId: widget.customerId), // Show Update Data
              ),
            ],
          ),
        ),
      ),
    );
  }

  constSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }

  diveider(BuildContext context) {
    return Divider(
      indent: displayWidth(context) * 0.05,
      endIndent: displayWidth(context) * 0.05,
      color: Colors.grey, // Customize the color
      thickness: 1, // Set thickness for the border
    );
  }
}
