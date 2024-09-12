import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../authenticate/view/login_screen.dart';
import '../../view_model/on_boarding_view_model.dart';
import '../on_boarding_screen.dart';

class RadioButton extends ConsumerWidget {
  const RadioButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = ref.watch(radiosProvider);
    return Container(
      width: displayWidth(context),
      height: displayHeight(context)*0.12,
      child: Wrap(
        children: [
          radios(
              context: context,
              ref: ref,
              value: Roles.All,
              selectedValue: selectedValue,
              title: 'All'),
          radios(
              context: context,
              ref: ref,
              value: Roles.Approved,
              selectedValue: selectedValue,
              title: 'Approved'),
          radios(
              context: context,
              ref: ref,
              value: Roles.Pending,
              selectedValue: selectedValue,
              title: 'Pending'),
          radios(
              context: context,
              ref: ref,
              value: Roles.Incomplete,
              selectedValue: selectedValue,
              title: 'Incomplete'),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: radios(
                context: context,
                ref: ref,
                value: Roles.Rejected,
                selectedValue: selectedValue,
                title: 'Rejected'),
          ),
        ],
      ),
    );
  }

  Widget radios(
      {required BuildContext context,
        required Roles selectedValue,
        required WidgetRef ref,
        required String title,
        required Roles value}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.30,
      child: Row(
        children: [
          Radio<Roles>(
            value: value,
            groupValue: selectedValue,
            onChanged: (value) {
              if (value != null) {
                ref.read(radiosProvider.notifier).select(value);
              }
            },
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }
}
