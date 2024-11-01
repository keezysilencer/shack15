import '../models/member_model.dart';

class MemberService {
  // Simulated data
  static List<Member> getDummyMembers() {
    return [
      Member(
        id: '1',
        name: 'Sarah Johnson',
        role: 'CEO',
        company: 'TechStart Innovation',
        imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
        interests: ['AI', 'Startups', 'Venture Capital'],
        bio: 'Building the future of AI-driven startups',
        isAvailableForNetworking: true,
      ),
    ];
  }
}
