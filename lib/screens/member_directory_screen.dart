import 'package:flutter/material.dart';

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('SHACK15 Members', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              onChanged: filterMembers,
              decoration: InputDecoration(
                hintText: 'Search members by name, company, or interests',
                prefixIcon: Icon(Icons.search),
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
                await Future.delayed(Duration(seconds: 1));
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
    );
  }
}
