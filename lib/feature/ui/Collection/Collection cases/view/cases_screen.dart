import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'CollectionDue/collection_due_screen.dart';
import 'visitPending/visit_pending_screen.dart';

class CollectionCasesScreen extends ConsumerWidget {
  const CollectionCasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Visit Pending',
                ),
                Tab(
                  text: 'Collection Due',
                  // icon: Icon(Icons),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            key: Key('Key1'),
            children: <Widget>[
              Center(
                child: VisitPendingScreen(),
              ),
              Center(
                child: CollectionDue(),
              ),
            ],
          ),
        ));
  }
}
