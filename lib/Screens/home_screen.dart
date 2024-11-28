// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'location_details_screen.dart';
import 'custom_drawer.dart'; // Import the LocationDetailsScreen for navigation

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterBar(),
          Expanded(
            child: _buildAttendanceList(context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                // Handle map view action (if necessary)
              },
              child: const Text(
                "Show Map View",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'ATTENDANCE',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4535A7),
              Color(0xFF3D2F96),
              Color(0xFF513FC8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    final String currentDate =
        DateFormat('EEE, MMM dd yyyy').format(DateTime.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffb3c1f1),
                    ),
                    child: const Icon(Icons.group, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'All Members',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.blue),
                onPressed: () {
                  // Open date picker or calendar view
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceList(BuildContext context) {
    List<Map<String, dynamic>> attendanceData = [
      {"name": "John Doe", "status": "Present", "id": "1"},
      {"name": "Jane Smith", "status": "Absent", "id": "2"},
    ];

    return ListView.builder(
      itemCount: attendanceData.length,
      itemBuilder: (context, index) {
        var item = attendanceData[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            title: Text(item['name']),
            subtitle: Text('Status: ${item['status']}'),
            trailing: IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationDetailsScreen(memberId: item['id']),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
