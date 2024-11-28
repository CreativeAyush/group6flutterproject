import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Import latlong2 for LatLng
import 'routedetail.dart'; // Import the RouteDetailPage

class LocationDetailsScreen extends StatefulWidget {
  final String name;
  final double latitude;
  final double longitude;

  const LocationDetailsScreen({
    Key? key,
    required this.name,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  _LocationDetailsScreenState createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  late LatLng currentLocation;
  late List<LatLng> visitedLocations;
  late List<String> locationTimeline;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Initialize currentLocation with passed latitude and longitude
    currentLocation = LatLng(widget.latitude, widget.longitude);

    // Sample locations to simulate travel
    visitedLocations = [
      currentLocation,
      LatLng(widget.latitude + 0.01,
          widget.longitude + 0.01), // Slightly northeast
      LatLng(widget.latitude + 0.02,
          widget.longitude - 0.01), // Slightly southeast
      LatLng(widget.latitude - 0.01,
          widget.longitude - 0.02), // Slightly southwest
    ];

    // Create a timeline based on visitedLocations
    locationTimeline = [
      '${visitedLocations[0].latitude}, ${visitedLocations[0].longitude} - ${DateTime.now().subtract(const Duration(minutes: 30))}',
      '${visitedLocations[1].latitude}, ${visitedLocations[1].longitude} - ${DateTime.now().subtract(const Duration(minutes: 20))}',
      '${visitedLocations[2].latitude}, ${visitedLocations[2].longitude} - ${DateTime.now().subtract(const Duration(minutes: 10))}',
      '${visitedLocations[3].latitude}, ${visitedLocations[3].longitude} - ${DateTime.now()}',
    ];
  }

  // Filter locations by the selected date
  List<String> _filterLocationsByDate() {
    return locationTimeline.where((entry) {
      final entryDate = DateTime.parse(entry.split(' - ')[1]);
      return entryDate.year == selectedDate.year &&
          entryDate.month == selectedDate.month &&
          entryDate.day == selectedDate.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredTimeline = _filterLocationsByDate();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 29, 150),
        title: const Text('TRACK LIVE LOCATION',
            style: TextStyle(color: Colors.white)),
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
            // Container with human icon and clickable text below AppBar and above map
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200], // Background color for the container
              child: Row(
                children: [
                  const Icon(
                    Icons.person, // Human icon
                    size: 30,
                    color: Color.fromRGBO(98, 77, 227, 1), // Custom color
                  ),
                  const SizedBox(width: 10), // Space between the icon and text
                  GestureDetector(
                    onTap: () {
                      // Handle the tap event (you can add your logic here)
                      print("Tapped on ${widget.name}");
                      // For example, navigate to another screen or show a message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped on ${widget.name}')),
                      );
                    },
                    child: Text(
                      widget.name, // Name passed from the list
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Change text color if needed
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Map view with expanded space
            SizedBox(
              height: 300, // Fixed height for the map container
              child: FlutterMap(
                options: MapOptions(
                  center: currentLocation, // Use the currentLocation
                  zoom: 15.0, // Set the zoom level
                  minZoom: 10.0, // Optional, minimum zoom level
                  maxZoom: 20.0, // Optional, maximum zoom level
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: visitedLocations,
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: visitedLocations
                        .map((location) => Marker(
                              width: 80.0,
                              height: 80.0,
                              point: location,
                              builder: (ctx) => const Icon(Icons.location_on,
                                  color: Colors.blue),
                            ))
                        .toList(),
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
                      onTap: () {
                        // When a route is tapped, navigate to RouteDetailPage
                        int index = filteredTimeline.indexOf(location);
                        if (index != -1) {
                          List<LatLng> selectedRoute = [
                            visitedLocations[index],
                            visitedLocations[index + 1]
                          ];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RouteDetailPage(
                                name: widget.name, // Pass the name
                                routeLocations:
                                    selectedRoute, // Pass the routeLocations
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
