import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'location_details_screen.dart'; // Import the LocationDetailsScreen
import 'custom_drawer.dart'; // Import CustomDrawer
import 'show_map.dart'; // Import ShowMap
import 'memberspage.dart'; // Import MembersPage
import 'livelocation.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> attendanceData = [
      {
        'name': 'Ayush Yadav',
        'id': 'WSL0003',
        'status': '',
        'inTime': '09:30 am',
        'outTime': '07:45 pm',
        'avatarUrl': '',
        'statusColor': Colors.green,
        'latitude': 37.7830,
        'longitude': -122.4170,
      },
      {
        'name': 'Ayush Sharma',
        'id': 'WSL0034',
        'status': '',
        'inTime': '09:30 am',
        'outTime': '06:40 pm',
        'avatarUrl': 'https://via.placeholder.com/50',
        'statusColor': Colors.orange,
        'latitude': 37.7830,
        'longitude': -122.4170,
      },
      {
        'name': 'Harshit Sharma',
        'id': 'WSL0054',
        'status': 'Working',
        'inTime': null,
        'outTime': null,
        'avatarUrl': 'https://via.placeholder.com/50',
        'statusColor': Colors.green,
        'latitude': 37.7830,
        'longitude': -152.4170,
      },
      {
        'name': 'Anjali Tyagi',
        'id': 'WSL0054',
        'status': '',
        'inTime': '09:30 am',
        'outTime': '06:40 pm',
        'avatarUrl': 'https://via.placeholder.com/50',
        'statusColor': Colors.grey,
        'latitude': 37.7830,
        'longitude': -122.4170,
      },
    ];

    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterBar(context),
          Expanded(
            child: _buildAttendanceList(attendanceData),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowMap(
                      members: attendanceData, // Pass the list of member data
                    ),
                  ),
                );
              },
              child: const Text(
                "Show Map View",
                style: TextStyle(
                  color: Color.fromARGB(255, 24, 108, 177),
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
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white, // Set the hamburger icon color to white
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

  Widget _buildFilterBar(BuildContext context) {
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MembersPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'All Members',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // Handle "Change" action
                },
                child: const Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_left, color: Colors.blue),
                onPressed: () {},
              ),
              Text(
                currentDate,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right, color: Colors.blue),
                onPressed: () {},
              ),
              const SizedBox(width: 15),
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey, height: 1, thickness: 1, indent: 16, endIndent: 16),
      ],
    );
  }

  Widget _buildAttendanceList(List<Map<String, dynamic>> attendanceData) {
    return ListView.builder(
      itemCount: attendanceData.length,
      itemBuilder: (context, index) {
        final item = attendanceData[index];
        return Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationDetailsScreen(
                      name: item['name'],
                      latitude: item['latitude'],
                      longitude: item['longitude'],
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: item['statusColor'],
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                '${item['name']} (${item['id']})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: [
                  if (item['inTime'] != null)
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                        const SizedBox(width: 4),
                        Text(item['inTime'], style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  if (item['outTime'] != null)
                    Row(
                      children: [
                        const Icon(Icons.arrow_downward, color: Colors.red, size: 16),
                        const SizedBox(width: 4),
                        Text(item['outTime'], style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  if (item['status'].isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: item['statusColor'],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item['status'],
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                ],
              ),
              
              trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    IconButton(
      icon: const Icon(Icons.calendar_today, color: Colors.black),
      onPressed: () {
        // Action for calendar icon
      },
    ),
    const SizedBox(width: 8), // Add spacing between icons
    IconButton(
      icon: const Icon(Icons.location_on, color: Colors.blue),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LiveLocationScreen(
              name: item['name'],
              latitude: item['latitude'],
              longitude: item['longitude'],
            ),
          ),
        );
      },
    ),
  ],
),
            ),

            const Divider(color: Colors.grey, height: 1, thickness: 1, indent: 16, endIndent: 16),
          ],
        );
      },
    );
  }
}
