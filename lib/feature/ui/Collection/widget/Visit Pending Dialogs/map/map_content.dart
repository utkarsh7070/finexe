import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Collection cases/view_model/visit_pending_view_model.dart';


class MapContent extends ConsumerWidget{
  final double latitude;
  final double longitude;

  MapContent({super.key,required this.latitude,required this.longitude});

  // final LatLng destination = LatLng(latitude, longitude);
  List<LatLng> polylineCoordinates = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(currentLocationProvider);
    final polylines = ref.watch(polylineProvider);

      return currentLocation.when(
        data: (position) {
      final initialCameraPosition = CameraPosition(
        target: LatLng(latitude, longitude),
        // LatLng(position.latitude, position.longitude),
        zoom: 14.0,
      );

      return GoogleMap(
        rotateGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: initialCameraPosition,
        markers: {
         Marker(
          markerId: const MarkerId(''),
          position: LatLng(latitude, longitude),
        )
      },
        onMapCreated: (controller) {
          // ref.read(googleMapControllerProvider.notifier).setMapController(controller);
          ref.read(mapControllerProvider.notifier).state = controller;
          // _getDirections(ref: ref,origin:LatLng(position.latitude, position.longitude) ,destination: LatLng(latitude, longitude));
        },
      );
    }, error: (Object error, StackTrace stackTrace) {
          return const Text('data');
    }, loading: () {
          return SizedBox(
            height: displayHeight(context)*0.10,
            width: displayWidth(context)*0.30,
              child: const Center(child: CircularProgressIndicator()));
    });
  }
  // Function to get directions and update the polyline required provider
  void _getDirections(
      {required WidgetRef ref, required LatLng origin, required LatLng destination}) async {
    final directions = await ref.read(directionsProvider(destination).future);
    print("directions $directions");
    if (directions.isNotEmpty) {
      final polyline =
      Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.blue,
        width: 5,
        points: directions,
      );
      ref.read(polylineProvider.notifier).state = [polyline];
    }
  }

  // void openMap(double latitude, double longitude) async {
  //   final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  //   final appleMapsUrl = 'https://maps.apple.com/?q=$latitude,$longitude';
  //
  //   if (await canLaunch(googleMapsUrl)) {
  //     await launch(googleMapsUrl);
  //   } else if (await canLaunch(appleMapsUrl)) {
  //     await launch(appleMapsUrl);
  //   } else {
  //     throw 'Could not open the map.';
  //   }
  // }
}
