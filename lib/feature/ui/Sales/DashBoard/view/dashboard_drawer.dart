import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/utils/namespase/display_size.dart';
import '../view_model/dashboard_view_model.dart';

class DrawerScreen extends ConsumerWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemViewModelProvider);
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: displayHeight(context)*0.05,),
              SizedBox(
                // height: displayHeight(context) * 0.07,
                width: displayWidth(context) * 0.50,
                // decoration: const BoxDecoration(
                child: Image.asset('assets/images/logo_finexe.png'),
              ),
              SizedBox(
                height: displayHeight(context),
                width: displayWidth(context),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    if(items[index].isExpanded!){
                      return ExpansionTile(leading: Icon(items[index].iconData),
                        title:Text(items[index].title!) ,
                      );
                    }
                    return Container(

                      color: index==0?AppColors.primery:null,
                      child: ListTile(
                        leading: Icon(items[index].iconData,color: AppColors.white,),
                        title:Text(items[index].title!) ,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
