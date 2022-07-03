import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:balinese_tour_app/models/wisata_model.dart';

class CurentMap extends StatefulWidget {
  final Wisata wisata;
  CurentMap({required this.wisata});

  @override
  State<CurentMap> createState() => _CurentMapState();
}

class _CurentMapState extends State<CurentMap> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition initialPosition = CameraPosition(
      target: LatLng(34.04633684784594, -118.26758436735804), zoom: 14.0);

  Set<Marker> markers = {};

  @override
  void initState() {
    goToUndiksha();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    child: Image.network('http://ilkom01.mhs.rey1024.com/laravel/storage/app/public/images/' +
                      widget.wisata.image, fit: BoxFit.fill),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new,
                            color: Colors.deepPurpleAccent),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(widget.wisata.name, style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                   Positioned(
                    bottom: 20,
                    left: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(widget.wisata.location, style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),         
              SizedBox(
                width: MediaQuery.of(context).size.width, // or use fixed size like 200
                height: 500,
                child: GoogleMap(
                  initialCameraPosition: initialPosition,
                  markers: markers,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> goToUndiksha() async {
    final CameraPosition targetPosition = CameraPosition(
      target: LatLng(double.parse(widget.wisata.lat), double.parse(widget.wisata.long)),
      zoom: 14.0,
      bearing: 192.0,
      tilt: 60);
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));

    markers.add(Marker(
        markerId: const MarkerId(''),
        position: LatLng(double.parse(widget.wisata.lat), double.parse(widget.wisata.long))));

    setState(() {});
  }
}
