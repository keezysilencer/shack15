import 'dart:math';

import 'package:flutter/material.dart';

import '../models/member_model.dart';
import '../service/member_service.dart';
import '../widgets/networking_card.dart';

class NetworkingSwipeScreen extends StatefulWidget {
  @override
  _NetworkingSwipeScreenState createState() => _NetworkingSwipeScreenState();
}

class _NetworkingSwipeScreenState extends State<NetworkingSwipeScreen> {
  List<Member> members = MemberService.getDummyMembers();
  int currentIndex = 0;
  double x = 0;
  double y = 0;
  double angle = 0;
  bool isDragging = false;
  Size screenSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    if (members.isEmpty || currentIndex >= members.length) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No more members to display!',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  members = MemberService.getDummyMembers();
                  currentIndex = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text('Refresh'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Network',
        ),
        // backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (currentIndex < members.length - 1)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: NetworkingCard(
                            member: members[currentIndex + 1],
                            isFront: false,
                            backgroundColor: Colors.grey.shade800,
                          ),
                        ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onPanStart: (details) {
                            setState(() {
                              isDragging = true;
                            });
                          },
                          onPanUpdate: (details) {
                            setState(() {
                              x += details.delta.dx;
                              y += details.delta.dy;
                              angle = 45 * x / screenSize.width;
                            });
                          },
                          onPanEnd: (details) {
                            final status = getStatus();
                            if (status == CardStatus.like) {
                              like();
                            } else if (status == CardStatus.dislike) {
                              dislike();
                            } else {
                              resetPosition();
                            }
                          },
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(x, y)
                              ..rotateZ(angle * pi / 180),
                            child: Stack(
                              children: [
                                NetworkingCard(
                                  member: members[currentIndex],
                                  isFront: true,
                                  backgroundColor: Colors.black,
                                ),
                                if (isDragging) ...[
                                  _buildSwipeIndicator(
                                    'CONNECT',
                                    Colors.greenAccent,
                                    alignment: Alignment.topRight,
                                    rotationAngle: 12,
                                  ),
                                  _buildSwipeIndicator(
                                    'PASS',
                                    Colors.redAccent,
                                    alignment: Alignment.topLeft,
                                    rotationAngle: -12,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(Icons.close, Colors.redAccent, dislike),
                  _buildActionButton(Icons.favorite, Colors.greenAccent, like),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build action buttons with premium styling
  Widget _buildActionButton(IconData icon, Color color, VoidCallback onPressed) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.black,
      child: Icon(icon, color: color, size: 32),
    );
  }

  // Build swipe indicator text for like/pass actions
  Widget _buildSwipeIndicator(String text, Color color, {Alignment alignment = Alignment.topRight, double rotationAngle = 0}) {
    return Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: rotationAngle * pi / 180,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void resetPosition() {
    setState(() {
      isDragging = false;
      x = 0;
      y = 0;
      angle = 0;
    });
  }

  void like() {
    setState(() {
      angle = 20;
      x = screenSize.width;
    });

    nextCard(CardStatus.like);
  }

  void dislike() {
    setState(() {
      angle = -20;
      x = -screenSize.width;
    });

    nextCard(CardStatus.dislike);
  }

  void nextCard(CardStatus status) {
    if (status == CardStatus.like) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection request sent to ${members[currentIndex].name}!'),
          backgroundColor: Colors.greenAccent,
        ),
      );
    }

    setState(() {
      currentIndex++;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        x = 0;
        y = 0;
        angle = 0;
        isDragging = false;
      });
    });
  }

  CardStatus? getStatus() {
    final delta = 100;
    if (x >= delta) return CardStatus.like;
    if (x <= -delta) return CardStatus.dislike;
    return null;
  }
}

enum CardStatus { like, dislike }
