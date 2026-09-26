import 'package:flutter/material.dart';
import 'age_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color blue = Color(0xFFBCEBFF);
  static const Color blueStrong = Color(0xFF8DD5FF);
  static const Color purple = Color(0xFFD8D0FF);
  static const Color purpleStrong = Color(0xFFBEB3FF);
  static const Color dark = Color(0xFF45466F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8FDFF),
              Color(0xFFE9F8FF),
              Color(0xFFF0EDFF),
              Color(0xFFFAF9FF),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // =========================================================
                  // SOFT BACKGROUND GLOW
                  // =========================================================

                  Positioned(
                    top: -100,
                    left: -80,
                    child: _glow(
                      size: 260,
                      color: blueStrong,
                    ),
                  ),

                  Positioned(
                    bottom: -100,
                    right: -80,
                    child: _glow(
                      size: 280,
                      color: purpleStrong,
                    ),
                  ),

                  // =========================================================
                  // FOUR CORNER ROBOT FRAME
                  // FULL IMAGE — NO CROPPING
                  // =========================================================

                  Positioned.fill(
                    child: IgnorePointer(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Image.asset(
                          'assets/images/image.png',
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),

                  // =========================================================
                  // CENTER CONTENT
                  // =========================================================

                  Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 30,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // AI BADGE
                            _buildAiBadge(),

                            const SizedBox(height: 20),

                            // SMALL LABEL
                            _buildSmallLabel(),

                            const SizedBox(height: 12),

                            // NEXLEARN TITLE
                            _buildTitle(),

                            const SizedBox(height: 12),

                            // SUBTITLE
                            const Text(
                              '4 ADVENTURES • ENDLESS MISSIONS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 3.2,
                                color: Color(0xFF8586A8),
                              ),
                            ),

                            const SizedBox(height: 34),

                            // PLAY BUTTON
                            _buildPlayButton(context),

                            const SizedBox(height: 22),
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
      ),
    );
  }

  // ============================================================
  // SOFT GLOW
  // ============================================================

  Widget _glow({
    required double size,
    required Color color,
  }) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(0.16),
              color.withOpacity(0.04),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // AI BADGE
  // ============================================================

  Widget _buildAiBadge() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFD6F4FF),
            Color(0xFFDCD5FF),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: blueStrong.withOpacity(0.20),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: purpleStrong.withOpacity(0.15),
            blurRadius: 35,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.45),
              shape: BoxShape.circle,
            ),
          ),
          const Icon(
            Icons.smart_toy_rounded,
            color: dark,
            size: 32,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SMALL LABEL
  // ============================================================

  Widget _buildSmallLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.62),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: purpleStrong.withOpacity(0.10),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            size: 14,
            color: purpleStrong,
          ),
          SizedBox(width: 6),
          Text(
            'PLAY • LEARN • GROW',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              color: dark,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MAIN TITLE
  // ============================================================

  Widget _buildTitle() {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF6CCBFF),
            Color(0xFF7E8FFF),
            Color(0xFFA88EFF),
          ],
        ).createShader(bounds);
      },
      child: const Text(
        'NEXLEARN',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 44,
          height: 0.95,
          fontWeight: FontWeight.w900,
          letterSpacing: -2.2,
          color: Colors.white,
        ),
      ),
    );
  }

  // ============================================================
  // PLAY BUTTON
  // ============================================================

  Widget _buildPlayButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // NEW FLOW:
        // HOME → AGE
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AgeScreen(),
          ),
        );
      },
      child: Container(
        width: 245,
        height: 70,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF9DDBFF),
              Color(0xFFB8CFFF),
              Color(0xFFC9BBFF),
            ],
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: blueStrong.withOpacity(0.28),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: purpleStrong.withOpacity(0.20),
              blurRadius: 35,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_arrow_rounded,
              color: dark,
              size: 34,
            ),
            SizedBox(width: 8),
            Text(
              "LET'S PLAY",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.3,
                color: dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}