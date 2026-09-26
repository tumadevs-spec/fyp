import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'subject_screen.dart';

class LevelScreen extends StatefulWidget {
  final int age;

  const LevelScreen({
    super.key,
    required this.age,
  });

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen>
    with SingleTickerProviderStateMixin {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color skyBlue = Color(0xFFEAF9FF);
  static const Color softBlue = Color(0xFFDDF3FF);
  static const Color lightPurple = Color(0xFFF1EDFF);
  static const Color purple = Color(0xFF8D7CF5);
  static const Color deepPurple = Color(0xFF6758D9);

  static const Color darkText = Color(0xFF29264A);
  static const Color softText = Color(0xFF777392);

  // ============================================================
  // ANIMATION
  // ============================================================

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ============================================================
  // PLAYER DESCRIPTION
  // ============================================================

  String get playerTitle {
    switch (widget.age) {
      case 6:
        return 'TINY ADVENTURER';

      case 7:
        return 'MINI ADVENTURER';

      case 8:
        return 'LITTLE EXPLORER';

      case 9:
        return 'BRAVE EXPLORER';

      case 10:
        return 'BOLD ADVENTURER';

      case 11:
        return 'QUEST ADVENTURER';

      case 12:
        return 'BIG ADVENTURER';

      default:
        return 'ADVENTURER';
    }
  }


  // ============================================================
  // ADVENTURE MESSAGE
  // ============================================================

  String get adventureMessage {
    switch (widget.age) {
      case 6:
        return 'Your very first adventure is about to begin!';

      case 7:
        return 'A brand-new adventure is waiting for you!';

      case 8:
        return 'Your explorer journey is getting bigger!';

      case 9:
        return 'Brave explorers are ready for new quests!';

      case 10:
        return 'A bigger world is opening up for you!';

      case 11:
        return 'You are ready for bigger quests and challenges!';

      case 12:
        return 'You are ready to explore the biggest adventures!';

      default:
        return 'Your adventure is waiting for you!';
    }
  }

  // ============================================================
  // NEX CURRICULUM STAGE
  //
  // ONLY NEX-1 TO NEX-6 EXIST.
  // ============================================================

  int get nexStage {
    switch (widget.age) {
      case 6:
        return 1;

      case 7:
        return 2;

      case 8:
        return 3;

      case 9:
        return 4;

      case 10:
        return 5;

      case 11:
      case 12:
        return 6;

      default:
        return 1;
    }
  }

  String get nexJourney => 'NEX-$nexStage';

  String get classText => 'CLASS $nexStage';

  // ============================================================
  // MAIN BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              skyBlue,
              lightPurple,
              Color(0xFFE7E1FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const _BackgroundDecorations(),

              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return _FloatingStars(
                    animationValue: _controller.value,
                  );
                },
              ),

              Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 18,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 520,
                    ),
                    child: Column(
                      children: [
                        // ROBOT
                        _buildRobot(),

                      
                        const SizedBox(height: 9),

                        // PLAYER TITLE
                        _buildPlayerTitle(),

                        const SizedBox(height: 10),

                        // MESSAGE
                        _buildAdventureMessage(),

                        const SizedBox(height: 24),

                        // JOURNEY CARD
                        _buildJourneyCard(),

                        const SizedBox(height: 24),

                        // BUTTON
                        _buildContinueButton(),

                        const SizedBox(height: 16),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRobot() {
  return AnimatedBuilder(
    animation: _controller,
    builder: (context, child) {
      final double floatY =
          math.sin(_controller.value * math.pi * 2) * 5;

      return Transform.translate(
        offset: Offset(0, floatY),
        child: child,
      );
    },
    child: SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft glow behind the robot
          Container(
            width: 125,
            height: 125,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.45),
            ),
          ),

          // YOUR ACTUAL ROBOT PNG
          Image.asset(
            'assets/images/robot.png',
            width: 135,
            height: 135,
            fit: BoxFit.contain,
          ),

          // Small floating sparkle
          Positioned(
            top: 12,
            right: 3,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 21,
              color: const Color(0xFF9586F4).withOpacity(0.8),
            ),
          ),
        ],
      ),
    ),
  );
}


  // ============================================================
  // PLAYER TITLE
  // ============================================================

  Widget _buildPlayerTitle() {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            deepPurple,
            Color(0xFF806FE7),
            Color(0xFF4C9CD9),
          ],
        ).createShader(bounds);
      },
      child: Text(
        playerTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 31,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.4,
          color: Colors.white,
          shadows: <Shadow>[],
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  Widget _buildAdventureMessage() {
    return Text(
      adventureMessage,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: softText,
        height: 1.4,
        shadows: <Shadow>[],
      ),
    );
  }

  // ============================================================
  // JOURNEY CARD
  // ============================================================

  Widget _buildJourneyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        22,
        22,
        22,
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: purple.withOpacity(0.13),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'WELCOME TO YOUR',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              color: softText,
              shadows: <Shadow>[],
            ),
          ),

          const SizedBox(height: 7),

          Text(
            nexJourney,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: darkText,
              letterSpacing: 1,
              shadows: <Shadow>[],
            ),
          ),

          const SizedBox(height: 2),

          const Text(
            'ADVENTURE JOURNEY',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.2,
              color: purple,
              shadows: <Shadow>[],
            ),
          ),

          const SizedBox(height: 20),

          // Journey path
          Row(
            children: [
              _journeyPoint(
                icon: Icons.person_rounded,
                active: true,
              ),

              _journeyLine(active: true),

              _journeyPoint(
                icon: Icons.explore_rounded,
                active: true,
              ),

              _journeyLine(active: true),

              _journeyPoint(
                icon: Icons.flag_rounded,
                active: true,
              ),
            ],
          ),

          const SizedBox(height: 15),

         
        ],
      ),
    );
  }

  // ============================================================
  // JOURNEY POINT
  // ============================================================

  Widget _journeyPoint({
    required IconData icon,
    required bool active,
  }) {
    return Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: active
            ? const LinearGradient(
                colors: [
                  Color(0xFFBCEBFF),
                  Color(0xFFCFC5FF),
                ],
              )
            : null,
        color: active
            ? null
            : const Color(0xFFF0EEF8),
      ),
      child: Icon(
        icon,
        size: 20,
        color: active
            ? deepPurple
            : const Color(0xFFAAA5BF),
      ),
    );
  }

  // ============================================================
  // JOURNEY LINE
  // ============================================================

  Widget _journeyLine({
    required bool active,
  }) {
    return Expanded(
      child: Container(
        height: 4,
        margin: const EdgeInsets.symmetric(
          horizontal: 6,
        ),
        decoration: BoxDecoration(
          gradient: active
              ? const LinearGradient(
                  colors: [
                    Color(0xFF9DDFFF),
                    Color(0xFFB5A7FF),
                  ],
                )
              : null,
          color: active
              ? null
              : const Color(0xFFE3E0F2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // ============================================================
  // BUTTON
  // ============================================================

  Widget _buildContinueButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SubjectScreen(
     
              classNumber: nexStage,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 61,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF9C8CFF),
              Color(0xFF7163DE),
            ],
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: deepPurple.withOpacity(0.25),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "START MY JOURNEY",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
                color: Colors.white,
                shadows: <Shadow>[],
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

 
}

// ================================================================
// BACKGROUND
// ================================================================

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -70,
            left: -60,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.38),
              ),
            ),
          ),

          Positioned(
            bottom: -90,
            right: -60,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD2C9FF)
                    .withOpacity(0.25),
              ),
            ),
          ),

          Positioned(
            top: 100,
            right: 28,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 23,
              color: Colors.white.withOpacity(0.8),
            ),
          ),

          Positioned(
            top: 220,
            left: 22,
            child: Icon(
              Icons.star_rounded,
              size: 17,
              color: const Color(0xFF9BDDF9)
                  .withOpacity(0.7),
            ),
          ),

          Positioned(
            bottom: 130,
            left: 28,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 19,
              color: const Color(0xFF9D8FF2)
                  .withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// FLOATING STARS
// ================================================================

class _FloatingStars extends StatelessWidget {
  final double animationValue;

  const _FloatingStars({
    required this.animationValue,
  });

  @override
  Widget build(BuildContext context) {
    final double movement =
        math.sin(animationValue * math.pi * 2) * 5;

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            left: 65,
            top: 65 + movement,
            child: _star(
              size: 9,
              opacity: 0.5,
            ),
          ),

          Positioned(
            right: 60,
            top: 250 - movement,
            child: _star(
              size: 8,
              opacity: 0.45,
            ),
          ),

          Positioned(
            left: 45,
            bottom: 170 + movement,
            child: _star(
              size: 7,
              opacity: 0.4,
            ),
          ),

          Positioned(
            right: 40,
            bottom: 80 - movement,
            child: _star(
              size: 10,
              opacity: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _star({
    required double size,
    required double opacity,
  }) {
    return Icon(
      Icons.star_rounded,
      size: size,
      color: Colors.white.withOpacity(opacity),
    );
  }
}