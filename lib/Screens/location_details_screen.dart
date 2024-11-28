// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Import latlong2 for LatLng

class LocationDetailsScreen extends StatefulWidget {
  final String memberId;

  const LocationDetailsScreen({Key? key, required this.memberId}) : super(key: key);

  @override
  _LocationDetailsScreenState createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  // Hardcoded data for current location and visited locations
  List<LatLng> visitedLocations = [
    LatLng(51.5074, -0.1278), // London
    LatLng(51.5075, -0.1279), // Nearby location in London
    LatLng(51.5080, -0.1280), // Another location in London
    LatLng(51.5090, -0.1290), // Another location in London
  ];

  List<String> locationTimeline = [
    "51.5074, -0.1278 - 2024-11-28 08:00:00", // Sample locations with timestamps
    "51.5075, -0.1279 - 2024-11-28 08:15:00",
    "51.5080, -0.1280 - 2024-11-28 08:30:00",
    "51.5090, -0.1290 - 2024-11-28 08:45:00",
  ];

  DateTime selectedDate = DateTime.now();

  // Static current location
  LatLng currentLocation = LatLng(51.5074, -0.1278); // London's coordinates

  // Track selected paths
  List<bool> selectedPaths = [false, false, false, false];

  @override
  void initState() {
    super.initState();
  }

  // Method to filter locations by the selected date
  List<String> _filterLocationsByDate() {
    return locationTimeline
        .where((entry) {
          final entryDate = DateTime.parse(entry.split(' - ')[1]);
          return entryDate.year == selectedDate.year &&
                 entryDate.month == selectedDate.month &&
                 entryDate.day == selectedDate.day;
        })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredTimeline = _filterLocationsByDate();

    return Scaffold(
      appBar: AppBar(
        title: Text('Location Details for Member: ${widget.memberId}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              // Show date picker for filtering visited locations
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (newDate != null && newDate != selectedDate) {
                setState(() {
                  selectedDate = newDate;
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map view with expanded space
            SizedBox(
              height: 300, // Fix height of the map container
              child: FlutterMap(
                options: MapOptions(
                  center: currentLocation, // Use the currentLocation
                  zoom: 15.0, // Set the zoom level
                  minZoom: 10.0, // Optional, you can set the minimum zoom level
                  maxZoom: 20.0, // Optional, you can set the maximum zoom level
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  PolylineLayer(
                    polylines: _getSelectedPolylines(),
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: visitedLocations.first,
                        builder: (ctx) => const Icon(Icons.play_arrow, color: Colors.green), // Start point
                      ),
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: visitedLocations.last,
                        builder: (ctx) => const Icon(Icons.stop, color: Colors.red), // Stop point
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Current Location:'),
                  Text(
                    'Latitude: ${currentLocation.latitude}, Longitude: ${currentLocation.longitude}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text('Visited Locations Timeline:'),
                  // List of filtered visited locations
                  ...filteredTimeline.map((location) {
                    return ListTile(
                      title: Text(location.split(' - ')[0]),
                      subtitle: Text(location.split(' - ')[1]),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  const Text('Select Paths to Display:'),
                  // Allow user to select paths
                  ...List.generate(visitedLocations.length, (index) {
                    return CheckboxListTile(
                      title: Text('Path ${index + 1}'),
                      value: selectedPaths[index],
                      onChanged: (bool? value) {
                        setState(() {
                          selectedPaths[index] = value!;
                        });
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to get selected polylines based on the selected paths
  List<Polyline> _getSelectedPolylines() {
    List<Polyline> polylines = [];
    for (int i = 0; i < visitedLocations.length - 1; i++) {
      if (selectedPaths[i]) {
        polylines.add(Polyline(
          points: [visitedLocations[i], visitedLocations[i + 1]],
          strokeWidth: 4.0,
          color: Colors.blue,
        ));
      }
    }
    return polylines;
  }
}
