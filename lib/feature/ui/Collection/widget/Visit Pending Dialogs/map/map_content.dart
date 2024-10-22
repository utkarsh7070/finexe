import 'dart:async';

import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Collection cases/view_model/visit_pending_view_model.dart';


class MapContent extends ConsumerWidget{
  MapContent({super.key});

  static const LatLng destination = const LatLng(45.521563, -122.677433);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(currentLocationProvider);
    final polylines = ref.watch(polylineProvider);

      return currentLocation.when(
        data: (position) {
      final initialCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.0,
      );

      return GoogleMap(

        initialCameraPosition: initialCameraPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        polylines: Set<Polyline>.of(polylines),
        onMapCreated: (controller) {
          ref.read(mapControllerProvider.notifier).state = controller;
          _getDirections(ref, destination);
        },
      );
    }, error: (Object error, StackTrace stackTrace) {
          return Text('data');
    }, loading: () {
          return SizedBox(
            height: displayHeight(context)*0.10,
            width: displayWidth(context)*0.30,
              child: Center(child: CircularProgressIndicator()));
    });
  }
  // Function to get directions and update the polyline provider
  void _getDirections(WidgetRef ref, LatLng destination) async {
    final directions = await ref.read(directionsProvider(destination).future);
    if (directions.isNotEmpty) {
      final polyline = Polyline(
        polylineId: PolylineId('route'),
        color: Colors.blue,
        width: 5,
        points: directions,
      );
      ref.read(polylineProvider.notifier).state = [polyline];
    }
  }
}
