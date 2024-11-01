import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/member_model.dart';
import '../service/member_service.dart';
import '../widgets/member_card.dart';
import 'networking_swipe_screen.dart';

class MemberDirectoryScreen extends StatefulWidget {
  @override
  _MemberDirectoryScreenState createState() => _MemberDirectoryScreenState();
}

class _MemberDirectoryScreenState extends State<MemberDirectoryScreen> {
  final List<Member> members = MemberService.getDummyMembers();
  List<Member> filteredMembers = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredMembers = members;
  }

  void filterMembers(String query) {
    setState(() {
      searchQuery = query;
      filteredMembers = members
          .where((member) =>
              member.name.toLowerCase().contains(query.toLowerCase()) ||
              member.company.toLowerCase().contains(query.toLowerCase()) ||
              member.interests.any((interest) => interest.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'SHACK15 Members',
          style: GoogleFonts.playfairDisplay(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              onChanged: filterMembers,
              style: GoogleFonts.lato(fontSize: 16, color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Search members by name, company, or interests',
                hintStyle: GoogleFonts.lato(color: Colors.black54),
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Simulate refresh
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  filterMembers(searchQuery);
                });
              },
              child: ListView.builder(
                itemCount: filteredMembers.length,
                itemBuilder: (context, index) {
                  final member = filteredMembers[index];
                  return MemberCard(member: member);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NetworkingSwipeScreen()),
          );
        },
        child: const Icon(Icons.swap_horiz, color: Colors.white),
        tooltip: 'Start Networking',
      ),
    );
  }
}
