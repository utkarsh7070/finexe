import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Collection cases/view_model/visit_pending_view_model.dart';

class MapContent extends ConsumerWidget{
  final LatLng destination; // Destination coordinates

  // Completer<GoogleMapController> _controller = Completer();
  //
  // static const LatLng _center = const LatLng(45.521563, -122.677433);


  MapContent({super.key,required this.destination});
  //
  // void _onMapCreated(GoogleMapController controller) {
  //   _controller.complete(controller);
  // }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(currentLocationProvider);
    final polylines = ref.watch(polylineProvider);
      return GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      );
  }

}