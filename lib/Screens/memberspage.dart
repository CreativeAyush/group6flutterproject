import 'package:flutter/material.dart';
import 'MembersDetailScreen.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  final List<Map<String, String>> members = [
    {'name': 'Ayush Yadav', 'id': 'M001'},
    {'name': 'Harshit sharma', 'id': 'M002'},
    {'name': 'Anjali Tyagi', 'id': 'M003'},
    {'name': 'Ayush Sharma', 'id': 'M004'},
    {'name': 'Maneesh Malhotra', 'id': 'M005'},
    {'name': 'Elizabeth Swann', 'id': 'M006'},
    {'name': 'Robert Downey', 'id': 'M007'},
    {'name': 'Francis Diakowsky', 'id': 'M008'},
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MEMBERS',
          style: TextStyle(color: Colors.white),
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                setState(() {
                  query = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                if (query.isNotEmpty &&
                    !member['name']!.toLowerCase().contains(query)) {
                  return const SizedBox.shrink();
                }
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xffb3c1f1),
                    child: Text(
                      member['name']![0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(member['name']!),
                  subtitle: Text('ID: ${member['id']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemberDetailsScreen(
                          name: member['name']!,
                          id: member['id']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
