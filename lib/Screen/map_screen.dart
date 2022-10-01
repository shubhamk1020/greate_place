import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLoaction initialLoaction;
  final bool isSelection;

  const MapScreen(
      {this.initialLoaction =
          const PlaceLoaction(latitude: 37.422, logitude: -122.084),
      this.isSelection = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your map'),
          actions: [
            if (widget.isSelection)
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: _pickedLocation == null ? null :() {
                  Navigator.of(context).pop(_pickedLocation);
                },
              )
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLoaction.latitude,
                widget.initialLoaction.logitude),
            zoom: 16,
          ),
          onTap: widget.isSelection ? _selectLocation : null,
          markers: (_pickedLocation == null && widget.isSelection)
              ? null
              : {
                  Marker(
                    markerId: const MarkerId('m1'),
                    position: _pickedLocation ?? LatLng(widget.initialLoaction.latitude, widget.initialLoaction.logitude),
                  ),
                },
        ));
  }
}
