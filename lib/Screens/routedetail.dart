import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Import latlong2 for LatLng

class RouteDetailPage extends StatelessWidget {
  final List<LatLng> routeLocations; // List of LatLng points to display the route on the map
  final String name; // Name for the route

  const RouteDetailPage({
    Key? key,
    required this.routeLocations,
    required this.name,
  }) : super(key: key);

  // Calculate the total distance between consecutive points
  double calculateTotalDistance() {
    if (routeLocations.isEmpty) {
      return 0.0; // No locations to calculate distance
    }

    double totalDistance = 0.0;
    var distance = Distance();

    for (int i = 0; i < routeLocations.length - 1; i++) {
      totalDistance += distance(routeLocations[i], routeLocations[i + 1]);
    }

    return totalDistance; // Total distance in meters
  }

  // Calculate the total duration based on the first and last location
  String calculateTotalDuration() {
    if (routeLocations.isEmpty) {
      return "00:00"; // No locations to calculate duration
    }

    // Example: Duration between first and last location
    DateTime startTime = DateTime.now().subtract(Duration(minutes: 60)); // Placeholder for actual start time
    DateTime endTime = DateTime.now(); // Placeholder for actual end time

    Duration duration = endTime.difference(startTime);
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    double totalDistance = calculateTotalDistance();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 29, 150),
        title: const Text('SEE ROUTE', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Container below the AppBar
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white, // Set the background color to white
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person, // Human icon
                      size: 30,
                      color: Colors.black, // Black icon color
                    ),
                    const SizedBox(width: 10), // Space between icon and name
                    Text(
                      name, // Display the route name
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10), // Space between name and locations
                Row(
                  children: [
                    const Icon(
                      Icons.location_on, // Start location icon
                      size: 30,
                      color: Colors.red, // Start location color
                    ),
                    const SizedBox(width: 10), // Space between icon and text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Start Location",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${routeLocations.first.latitude}, ${routeLocations.first.longitude}', // Coordinates of the first location
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10), // Space between locations
                Row(
                  children: [
                    const Icon(
                      Icons.location_on, // End location icon
                      size: 30,
                      color: Colors.green, // End location color
                    ),
                    const SizedBox(width: 10), // Space between icon and text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "End Location",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${routeLocations.last.latitude}, ${routeLocations.last.longitude}', // Coordinates of the last location
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10), // Space between locations and duration

                // Row for total duration and total distance
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.timer, // Icon for total duration
                          size: 30,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 10), // Space between icon and text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Time",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(calculateTotalDuration()),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_walk, // Icon for total distance
                          size: 30,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 10), // Space between icon and text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Distance",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('${(totalDistance / 1000).toStringAsFixed(2)} km'), // Convert meters to kilometers
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Map view with expanded space
          SizedBox(
            height: 300, // Fixed height for the map container
            child: FlutterMap(
              options: MapOptions(
                center: routeLocations.isNotEmpty ? routeLocations[0] : LatLng(0.0, 0.0),
                zoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routeLocations,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: routeLocations
                      .asMap()
                      .map((index, location) {
                        // Define different colors for the markers
                        Color markerColor;
                        if (index == 0) {
                          markerColor = Colors.red; // First location (start)
                        } else if (index == routeLocations.length - 1) {
                          markerColor = Colors.green; // Last location (end)
                        } else {
                          markerColor = Colors.blue; // Other locations
                        }

                        return MapEntry(
                          index,
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: location,
                            builder: (ctx) => Icon(
                              Icons.location_on,
                              color: markerColor,
                            ),
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
