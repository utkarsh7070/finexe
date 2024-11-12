


import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/lead_showing_view_model.dart';
import 'lead_generation_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeadListScreen extends ConsumerStatefulWidget {
  const LeadListScreen({super.key});

  @override
  _LeadListScreenState createState() => _LeadListScreenState();
}

class _LeadListScreenState extends ConsumerState<LeadListScreen> {
  final ScrollController _headerScrollController = ScrollController();
  final ScrollController _bodyScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _headerScrollController.addListener(() {
      _bodyScrollController.jumpTo(_headerScrollController.offset);
    });

    Future.microtask(() => ref.read(leadShowViewModelProvider).fetchLeads(context));
  }

  @override
  Widget build(BuildContext context) {
    final leadViewModel = ref.watch(leadShowViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Customer Details"),

        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,10,0),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Add lead action
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LeadGenerationForm())) // Replace with your second page widget
                        .then((refreshNeeded) {
                  // Check if refresh is needed
                  if (refreshNeeded == true) {
                    // Trigger the data refresh in the ViewModel
                    ref.read(leadShowViewModelProvider).fetchLeads(context);
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Status Filter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Pending"),
                Radio(value: 0, groupValue: 0, onChanged: (_) {}),
                Text("Approved"),
                Radio(value: 1, groupValue: 0, onChanged: (_) {}),
                Text("Rejected"),
                Radio(value: 2, groupValue: 0, onChanged: (_) {}),
              ],
            ),
            SizedBox(height: 20),
            // Horizontal Scrollable Table (Header + Body)
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Horizontal Scrollable Header
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _headerScrollController,
                      child: Row(
                        children: [
                          SizedBox(width: 150, child: Text('CUSTOMER NAME', style: TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(width: 150, child: Text('MOBILE NO', style: TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(width: 150, child: Text('LOAN AMOUNT', style: TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(width: 150, child: Text('CITY/VILLAGE NAME', style: TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(width: 100, child: Text('PINCODE', style: TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(width: 150, child: Text('ASSIGNED TO', style: TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(width: 100, child: Text('ACTION', style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    Divider(thickness: 2),
                    // Horizontal Scrollable Table Body (Rows)
                    leadViewModel.leads.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _bodyScrollController,
                      child: Column(
                        children: leadViewModel.leads.map((lead) {
                          return Container(
                            width: 1050,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 150, child: Text(lead.customerName ?? 'N/A')),
                                    SizedBox(width: 150, child: Text(lead.customerMobileNo ?? 'N/A')),
                                    SizedBox(width: 150, child: Text(lead.loanAmount.toString() ?? 'N/A')),
                                    SizedBox(width: 150, child: Text(lead.city ?? 'N/A')),
                                    SizedBox(width: 100, child: Text(lead.pincode ?? 'N/A')),
                                    SizedBox(width: 150, child: Text(lead.employeeAssignName ?? 'N/A')),
                                    SizedBox(
                                      width: 100,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Navigate to detailed view
                                        },
                                        child: Text(
                                          'View',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.grey, thickness: 0.5,), // Add gray divider below each row
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}














