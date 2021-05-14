import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:little_cake_story/model/directions.dart';
import 'package:little_cake_story/model/directions_repository.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(5.4164, 100.3327),
    zoom: 12,
  );
  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;

  @override
  void dispose() {

    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
            title: Text('Map',style: TextStyle(fontFamily: 'Arial')),
      actions: [
        if(_origin != null)
          TextButton(onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _origin.position,
              zoom: 16,
              tilt: 50,
            ))),
            style: TextButton.styleFrom(
              primary:Colors.blue,
              textStyle: const TextStyle(fontFamily: 'Arial',fontSize: 18)
            ), 
          child: Text("Origin")),
        if(_destination != null)
          TextButton(onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _destination.position,
              zoom: 16,
              tilt: 50,
            ))),
            style: TextButton.styleFrom(
              primary:Colors.red,
              textStyle: const TextStyle(fontFamily: 'Arial',fontSize: 18)
            ), 
        child: Text("Destination")),
      ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: {
            if(_origin != null) _origin,
            if(_destination != null) _destination,
          },
          polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
          onLongPress: _addMarker,
          ),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info.totalDistance}, ${_info.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[200],
        foregroundColor: Colors.black,
        onPressed:() => _googleMapController.animateCamera(
        _info != null
          ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
          : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong)),
    );
  }

  void _addMarker(LatLng pos) async {
    if(_origin == null || (_origin !=  null && _destination != null)){
      
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('Starting Point'),
          infoWindow: const InfoWindow(title:'Origin'),
          icon: 
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );

        //Reset Destination
        _destination = null;

        //Reset Info
        _info = null;
      });
    }else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('Destination'),
          infoWindow: const InfoWindow(title:'Destination'),
          icon: 
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
      });

       // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }
}