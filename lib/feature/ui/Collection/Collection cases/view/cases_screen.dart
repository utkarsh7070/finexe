import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/visit_pending_view_model.dart';
import 'visitPending/visit_pending_screen.dart';

class CollectionCasesScreen extends ConsumerWidget {
  const CollectionCasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return
      // DefaultTabController(
      //   initialIndex: 0,
      //   length: 2,
      //   child:
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Visit Details'),leading: BackButton(onPressed: () {
              Navigator.pop(context);
              ref.invalidate(fetchVisitPendingDataProvider);
            },),

            // bottom: const TabBar(
            //   tabs: <Widget>[
            //     Tab(
            //       text: 'Visit Pending',
            //     ),
            //     Tab(
            //       text: '',
            //       // icon: Icon(Icons),
            //     ),
            //   ],
            // ),
          ),
          body: const VisitPendingScreen()
          // const TabBarView(
          //   key: Key('Key1'),
          //   children: <Widget>[
          //     Center(
          //       child: VisitPendingScreen(),
          //     ),
          //     Center(
          //       child: CollectionDue(),
          //     ),
          //   ],
          // ),
        // )
    );
  }
}
