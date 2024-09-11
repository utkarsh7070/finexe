import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/routes/routes.dart';
import '../view_model/login_view_model.dart';

class Remember extends ConsumerWidget {
  const Remember({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRemember = ref.watch(rememberProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height *0.06,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: isRemember,
                onChanged: (value) {
                  if(isRemember!=true){
                    ref.read(rememberProvider.notifier).state = true;
                  }else{
                    ref.read(rememberProvider.notifier).state = false;
                  }
                },
              ),
              Text('Remember Me'),
            ],
          ),
          TextButton(onPressed: () {
            Navigator.pushNamed(context, AppRoutes.forgot);
          }, child: Text('Forgot Password!'))
        ],
      ),
    );
  }
}
