import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  static const LatLng _defaultLocation =
      LatLng(37.7749, -122.4194); // San Francisco
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: _defaultLocation,
    zoom: 11.0,
  );
  LatLng _lastMapPosition = _defaultLocation;
  final TextEditingController _searchController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Future<void> _searchDestination(String destination) async {
    List<Location> locations = await locationFromAddress(destination);
    if (locations.isNotEmpty) {
      Location location = locations.first;
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(location.latitude, location.longitude),
          14,
        ),
      );
      setState(() {
        _lastMapPosition = LatLng(location.latitude, location.longitude);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/car.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Center(
          child: Text(
            'Map Page',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepOrange, Colors.orange],
          ),
        ),
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialCameraPosition,
              onCameraMove: _onCameraMove,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
            Positioned(
              top: 10,
              right: 15,
              left: 15,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for a place',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, top: 15),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _searchDestination(_searchController.text);
                      },
                      iconSize: 30,
                    ),
                  ),
                  onSubmitted: _searchDestination,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapPage(),
  ));
}
