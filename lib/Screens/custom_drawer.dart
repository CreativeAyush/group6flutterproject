import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  icon: Icons.timer,
                  text: 'Timer',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.list_alt,
                  text: 'Attendance',
                  onTap: () {},
                  isHighlighted: true, // Highlights the item as selected
                ),
                _buildMenuItem(
                  icon: Icons.timeline,
                  text: 'Activity',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.access_time,
                  text: 'Timesheet',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.bar_chart,
                  text: 'Report',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.location_on,
                  text: 'Jobsite',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.people,
                  text: 'Team',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.beach_access,
                  text: 'Time off',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.schedule,
                  text: 'Schedules',
                  onTap: () {},
                ),
                const Divider(), // Separates the menu groups
                _buildMenuItem(
                  icon: Icons.add_circle_outline,
                  text: 'Request to join Organization',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.lock,
                  text: 'Change Password',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () {},
                ),
                const Divider(), // Separates the bottom items
                _buildMenuItem(
                  icon: Icons.help_outline,
                  text: 'FAQ & Help',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.privacy_tip_outlined,
                  text: 'Privacy Policy',
                  onTap: () {},
                ),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4535A7),
            Color(0xFF3D2F96),
            Color(0xFF513FC8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(children: [
        Row(
          children: [
            // Circular boundary around the icon
            Container(
              padding: const EdgeInsets.all(8), // Adjust padding for size
              // decoration: BoxDecoration(
              //   shape: BoxShape.circle,
              //   color: Color(0xffb3c1f1),
              // ),
              child: const Icon(
                Icons.task_alt,
                color: Colors.white,
                size: 15,
              ),
            ),
            const SizedBox(width: 1),
            const Text(
              'Workstatus',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        // Avatar
        // Row
        // s
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 20, // Adjust the size as needed
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 20, // Adjust size as needed
                color: Colors.grey[700], // Adjust color as needed
              ),
            ),
            const SizedBox(width: 16), // Space between avatar and text
            // User Details
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ayush Yadav',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color for better contrast
                  ),
                ),
                SizedBox(height: 2), // Small space between name and email
                Text(
                  'ayush@gmail.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white, // Text color for better contrast
                  ),
                ),
              ],
            ),
          ],
        )
      ]),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isHighlighted = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isHighlighted ? Colors.blue : Colors.grey[700],
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
          color: isHighlighted ? Colors.blue : Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        'Version: 2.10(1)',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}
