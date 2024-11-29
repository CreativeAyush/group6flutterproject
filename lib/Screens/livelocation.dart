import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LiveLocationScreen extends StatelessWidget {
  final String name;
  final double latitude;
  final double longitude;

  const LiveLocationScreen({
    Key? key,
    required this.name,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LatLng currentLocation = LatLng(latitude, longitude);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 29, 150),
        title: const Text(
          'LIVE LOCATION',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Container for name display
          Container(
            width: double.infinity, // Full width
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200], // Light grey background color
            child: Row(
              children: [
                const Icon(
                  Icons.person, // Person icon
                  size: 30,
                  color: Color.fromRGBO(98, 77, 227, 1), // Purple color
                ),
                const SizedBox(width: 10), // Space between icon and text
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Map view
          SizedBox(
            height: 300, // Fixed height for the map
            child: FlutterMap(
              options: MapOptions(
                center: currentLocation,
                zoom: 15.0,
                minZoom: 10.0,
                maxZoom: 20.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: currentLocation,
                      builder: (ctx) => const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Live Location Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Live Location:'),
                Text(
                  'Latitude: $latitude, Longitude: $longitude',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
