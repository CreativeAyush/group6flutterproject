import 'package:flutter/material.dart';
import '../main.dart';
import 'custom_drawer.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context), // Pass context for opening the drawer
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterBar(),
          Expanded(
            child: _buildAttendanceList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                // Handle map view action
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

  // Widget _buildDrawer() {
  //   return Drawer(
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: [
  //         DrawerHeader(
  //           decoration: BoxDecoration(
  //             color: Colors.blue,
  //           ),
  //           child: Text(
  //             'Menu',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 24,
  //             ),
  //           ),
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.home),
  //           title: Text('Home'),
  //           onTap: () {
  //             // Close the drawer
  //           },
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.settings),
  //           title: Text('Settings'),
  //           onTap: () {
  //             // Close the drawer
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildFilterBar() {
    final String currentDate =
        DateFormat('EEE, MMM dd yyyy').format(DateTime.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full-width grey background
        Container(
          width: double.infinity, // Full width
          color: Colors.grey.shade200, // Grey background color
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Circular boundary around the icon
                  Container(
                    padding: const EdgeInsets.all(8), // Adjust padding for size
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
        // Add spacing between rows
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_left,
                    color: Colors.blue), // Customize color if needed
                onPressed: () {
                  // Action for left arrow click
                  logger.i('Left arrow clicked');
                },
              ),
              Text(
                currentDate,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right,
                    color: Colors.blue), // Customize color if needed
                onPressed: () {
                  // Action for left arrow click
                  logger.i('right arrow clicked');
                },
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today,
                    color: Colors.grey), // Customize color if needed
                onPressed: () {
                  // Action for left arrow click
                  logger.i('calender');
                },
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey, // Line color
          height: 1, // Line thickness
          thickness: 1, // Line thickness
          indent: 16, // Indentation from the left
          endIndent: 16, // Indentation from the right
        ),
      ],
    );
  }

  Widget _buildAttendanceList() {
    final List<Map<String, dynamic>> attendanceData = [
      {
        'name': 'Ayush Yadav',
        'id': 'WSL0003',
        'status': '',
        'inTime': '09:30 am',
        'outTime': '07:45 pm',
        'avatarUrl': '',
        'statusColor': Colors.green,
      },
      {
        'name': 'Ayush Sharma',
        'id': 'WSL0034',
        'status': '',
        'inTime': '09:30 am',
        'outTime': '06:40 pm',
        'avatarUrl': 'https://via.placeholder.com/50',
        'statusColor': Colors.orange,
      },
      {
        'name': 'Harshit Sharma',
        'id': 'WSL0054',
        'status': 'Working',
        'inTime': null,
        'outTime': null,
        'avatarUrl': 'https://via.placeholder.com/50',
        'statusColor': Colors.green
      },
      {
        'name': 'Anjali Tyagi',
        'id': 'WSL0054',
        'status': '',
        'inTime': '09:30 am',
        'outTime': '06:40 pm',
        'avatarUrl': 'https://via.placeholder.com/50',
        'statusColor': Colors.grey,
      },
    ];

    return ListView.builder(
      itemCount: attendanceData.length,
      itemBuilder: (context, index) {
        final item = attendanceData[index];
        return Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundColor:
                    Color(0xffb3c1f1), // Background color for the circle
                child: Icon(
                  Icons.person,
                  color: Colors.white, // Icon color
                  size: 24, // Icon size
                ),
              ),
              title: Text(
                '${item['name']} (${item['id']})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item['inTime'] != null)
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          item['inTime'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  if (item['outTime'] != null)
                    Row(
                      children: [
                        const Icon(Icons.arrow_downward, color: Colors.red, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          item['outTime'],
                          style: const TextStyle(fontSize: 14),
                        ),
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
              trailing: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Timesheet Icon
                  Icon(Icons.calendar_today,
                      color: Color.fromRGBO(0, 35, 75, 1),
                      size: 25), // Calendar with rgba(0, 35, 75, 1)
                  SizedBox(width: 16),
                  // Location Icon
                  Icon(Icons.location_on,
                      color: Color.fromRGBO(98, 77, 227, 1),
                      size: 25), // Location with rgba(98, 77, 227, 1)
                ],
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            ),
            // Grey line separator between list items
            const Divider(
              color: Colors.grey, // Line color
              height: 1, // Line thickness
              thickness: 1, // Line thickness
              indent: 16, // Indentation from the left
              endIndent: 16, // Indentation from the right
            ),
          ],
        );
      },
    );
  }
}
