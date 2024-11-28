import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Import latlong2 for LatLng

class ShowMap extends StatelessWidget {
  final List<Map<String, dynamic>> members;

  const ShowMap({Key? key, required this.members}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Members' Locations"),
      ),
      body: Stack(
        children: [
          // Map Widget
          FlutterMap(
            options: MapOptions(
              center: _getMapCenter(), // Dynamically center the map
              zoom: 10.0, // Initial zoom level
              bounds: _getMapBounds(), // Fit all markers into view
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: _getMemberMarkers(),
              ),
            ],
          ),
          // Positioned "Show Map View" text at the bottom-left
          Positioned(
            bottom: 16,
            left: 16,
            child: GestureDetector(
              onTap: () {
                // Navigate back to the home screen
                Navigator.pop(context);
              },
              child: const Text(
                "Show List View",
                style: TextStyle(
                  color: Color.fromARGB(255, 24, 108, 177),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Dynamically determine map center based on all member locations
  LatLng _getMapCenter() {
    if (members.isEmpty) return LatLng(0, 0);

    final latitudes = members.map((member) => member['latitude'] as double).toList();
    final longitudes = members.map((member) => member['longitude'] as double).toList();

    final averageLat = latitudes.reduce((a, b) => a + b) / latitudes.length;
    final averageLng = longitudes.reduce((a, b) => a + b) / longitudes.length;

    return LatLng(averageLat, averageLng);
  }

  // Define bounds for all markers
  LatLngBounds _getMapBounds() {
    if (members.isEmpty) {
      return LatLngBounds(LatLng(-90, -180), LatLng(90, 180)); // Entire world
    }

    final latitudes = members.map((member) => member['latitude'] as double).toList();
    final longitudes = members.map((member) => member['longitude'] as double).toList();

    final south = latitudes.reduce((a, b) => a < b ? a : b);
    final north = latitudes.reduce((a, b) => a > b ? a : b);
    final west = longitudes.reduce((a, b) => a < b ? a : b);
    final east = longitudes.reduce((a, b) => a > b ? a : b);

    return LatLngBounds(LatLng(south, west), LatLng(north, east));
  }

  // Create markers for all members, each with a unique color
  List<Marker> _getMemberMarkers() {
    // Different colors for each member
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
      Colors.cyan,
    ];

    return members.asMap().entries.map((entry) {
      final index = entry.key;
      final member = entry.value;

      // Assign color based on index
      final color = colors[index % colors.length];

      return Marker(
        width: 100.0,
        height: 100.0,
        point: LatLng(member['latitude'], member['longitude']),
        builder: (ctx) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on, color: color, size: 40.0),
            Text(
              member['name'],
              style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }).toList();
  }
}
