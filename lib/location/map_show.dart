import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class MapSample extends StatefulWidget {

  final double latitude;
  final double longitude;
  MapSample(this.latitude, this.longitude);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
Set<Marker> _markers = {};

  void _onMapCreate(){
    setState(() {
      _markers.addAll(
          [
            Marker(
          markerId: MarkerId('id_1'),
          position: LatLng(27.677402607158157, 85.31699653920523),
          infoWindow: InfoWindow(
              snippet: 'Labim Mall',
              title: 'Labim Mall'
          )
      ),
            Marker(
                markerId: MarkerId('id_2'),
                position: LatLng(27.674989290581905, 85.31543013227133),
                infoWindow: InfoWindow(
                    snippet: 'Alka',
                    title: 'Alka'
                )
            )

          ]
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _markers,
        initialCameraPosition: CameraPosition(
            target: LatLng(27.6772126, 85.317018),
            zoom: 14.4746),
        onMapCreated: (GoogleMapController controller) {
          _onMapCreate();
          _controller.complete(controller);
        },
      ),
    );
  }


}