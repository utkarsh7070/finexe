import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AadhaarDetailsContent extends ConsumerWidget {
  const AadhaarDetailsContent({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return
      Container(
      child:
      Column(
        children: [
          Text('Aadhaar Details'),
          commonText(context: context,heading: 'Name',value:'' )
        ],
      ),
    );
  }

  Widget commonText({required BuildContext context, required String heading, required String value}){
    return SizedBox(
      width: displayWidth(context),
      child: Row(
          children: [
            Text(heading),
            Text(value)

          ],
      ),
    );
  }
}
