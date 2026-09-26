import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'level_screen.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen>
    with SingleTickerProviderStateMixin {
  int selectedAge = 6;

  final List<int> ages = List.generate(9, (index) => index + 4);

  late AnimationController _floatingController;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  void continueToLevel() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LevelScreen(age: selectedAge),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7FF),
      body: SafeArea(
        child: Stack(
          children: [
            // ============================================================
            // BACKGROUND
            // ============================================================

            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE9F8FF),
                    Color(0xFFF1EEFF),
                    Color(0xFFE8E1FF),
                  ],
                ),
              ),
            ),

            // ============================================================
            // DECORATIVE CIRCLES
            // ============================================================

            Positioned(
              top: -50,
              right: -35,
              child: _DecorCircle(
                size: 150,
                color: const Color(0xFFB9E9FF),
              ),
            ),

            Positioned(
              top: 210,
              left: -60,
              child: _DecorCircle(
                size: 125,
                color: const Color(0xFFD7C9FF),
              ),
            ),

            Positioned(
              bottom: -40,
              right: -40,
              child: _DecorCircle(
                size: 145,
                color: const Color(0xFFC7EDFF),
              ),
            ),

            // ============================================================
            // FLOATING STARS
            // ============================================================

            AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                final movement =
                    math.sin(_floatingController.value * math.pi * 2) * 5;

                return Stack(
                  children: [
                    Positioned(
                      top: 55 + movement,
                      left: 28,
                      child: const _GameStar(
                        size: 24,
                        color: Color(0xFF8C7CF2),
                      ),
                    ),
                    Positioned(
                      top: 125 - movement,
                      right: 38,
                      child: const _GameStar(
                        size: 18,
                        color: Color(0xFF6CCFF2),
                      ),
                    ),
                    Positioned(
                      bottom: 160 + movement,
                      left: 30,
                      child: const _GameStar(
                        size: 17,
                        color: Color(0xFFA28FFF),
                      ),
                    ),
                    Positioned(
                      bottom: 65 - movement,
                      right: 50,
                      child: const _GameStar(
                        size: 22,
                        color: Color(0xFF73D7F7),
                      ),
                    ),
                  ],
                );
              },
            ),

            // ============================================================
            // CONTENT
            // ============================================================

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 620,
                  ),
                  child: Column(
                    children: [
                      // ==================================================
                      // GAME ICON
                      // ==================================================

                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 92,
                            height: 92,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFB8EAFF),
                                  Color(0xFFD6C7FF),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF8175D7)
                                      .withOpacity(0.20),
                                  blurRadius: 22,
                                  offset: const Offset(0, 9),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.sports_esports_rounded,
                              size: 47,
                              color: Color(0xFF6255C7),
                            ),
                          ),
                          Positioned(
                            top: -4,
                            right: -4,
                            child: Container(
                              width: 27,
                              height: 27,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.auto_awesome_rounded,
                                size: 15,
                                color: Color(0xFF806FE4),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ==================================================
                      // LOGO TEXT
                      // ==================================================

                      const Text(
                        'NexLearn',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF29254A),
                          shadows: <Shadow>[],
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        'LET THE ADVENTURE BEGIN!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.8,
                          color: Color(0xFF7468C8),
                          shadows: <Shadow>[],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ==================================================
                      // MAIN GAME CARD
                      // ==================================================

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(23),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFFFFFFFF),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7168AE).withOpacity(0.12),
                              blurRadius: 28,
                              offset: const Offset(0, 14),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // ============================================
                            // PLAYER SETUP BADGE
                            // ============================================

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFE0F6FF),
                                    Color(0xFFEAE3FF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.bolt_rounded,
                                    size: 17,
                                    color: Color(0xFF7063D0),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'PLAYER SETUP',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1,
                                      color: Color(0xFF6257B6),
                                      shadows: <Shadow>[],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // ============================================
                            // QUESTION
                            // ============================================

                            const Text(
                              'How old is our player?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF29254A),
                                shadows: <Shadow>[],
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'Pick an age to start your adventure!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF77758D),
                                shadows: <Shadow>[],
                              ),
                            ),

                            const SizedBox(height: 25),

                            // ============================================
                            // AGE BUTTONS
                            // ============================================

                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 11,
                              runSpacing: 12,
                              children: ages.map((age) {
                                final bool selected = age == selectedAge;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedAge = age;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 220),
                                    curve: Curves.easeOut,
                                    width: 62,
                                    height: 62,
                                    decoration: BoxDecoration(
                                      gradient: selected
                                          ? const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFFB7EAFF),
                                                Color(0xFFD4C5FF),
                                              ],
                                            )
                                          : null,
                                      color: selected
                                          ? null
                                          : const Color(0xFFF8F8FF),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: selected
                                            ? const Color(0xFF8071EA)
                                            : const Color(0xFFE5E3F0),
                                        width: selected ? 2.5 : 1.5,
                                      ),
                                      boxShadow: selected
                                          ? [
                                              BoxShadow(
                                                color: const Color(0xFF8172E9)
                                                    .withOpacity(0.25),
                                                blurRadius: 16,
                                                offset: const Offset(0, 7),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Text(
                                          '$age',
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w900,
                                            color: selected
                                                ? const Color(0xFF5146A5)
                                                : const Color(0xFF55536B),
                                            shadows: const <Shadow>[],
                                          ),
                                        ),
                                        if (selected)
                                          Positioned(
                                            top: 4,
                                            right: 5,
                                            child: Container(
                                              width: 15,
                                              height: 15,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.check_rounded,
                                                size: 10,
                                                color: Color(0xFF6D5FE0),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 25),

                            // ============================================
                            // PLAYER AGE
                            // ============================================

                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Container(
                                key: ValueKey(selectedAge),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFEAF9FF),
                                      Color(0xFFF0EBFF),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.person_rounded,
                                        size: 21,
                                        color: Color(0xFF7668D7),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Player age: $selectedAge',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF45415F),
                                        shadows: <Shadow>[],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 22),

                            // ============================================
                            // START BUTTON
                            // ============================================

                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: continueToLevel,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF70D5F5),
                                          Color(0xFF8B78EF),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF8172E9)
                                              .withOpacity(0.25),
                                          blurRadius: 17,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.play_arrow_rounded,
                                            size: 28,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 7),
                                          Text(
                                            'START ADVENTURE',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: .5,
                                              color: Colors.white,
                                              shadows: <Shadow>[],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                     

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DECORATIVE CIRCLE
// ============================================================

class _DecorCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _DecorCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.35),
        shape: BoxShape.circle,
      ),
    );
  }
}

// ============================================================
// GAME STAR
// ============================================================

class _GameStar extends StatelessWidget {
  final double size;
  final Color color;

  const _GameStar({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.auto_awesome_rounded,
      size: size,
      color: color.withOpacity(0.65),
    );
  }
}