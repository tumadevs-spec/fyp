
import 'package:flutter/material.dart';
import 'mystery_game_screen.dart';
import '../widgets/back_button.dart';

class GameTypeSelectionScreen extends StatefulWidget {
  final int classNumber;
  final String subject;
  final String topicName;

  const GameTypeSelectionScreen({
    super.key,
    required this.classNumber,
    required this.subject,
    required this.topicName,
  });

  @override
  State<GameTypeSelectionScreen> createState() =>
      _GameTypeSelectionScreenState();
}

class _GameTypeSelectionScreenState
    extends State<GameTypeSelectionScreen>
    with SingleTickerProviderStateMixin {
  String? selectedMode;
  String? selectedGameType;

  late AnimationController _animationController;

  // ============================================================
  // COLORS
  // ============================================================

  static const Color sky = Color(0xFFEAF9FF);
  static const Color purple = Color(0xFF8B7CF6);
  static const Color dark = Color(0xFF302C49);
  static const Color muted = Color(0xFF77738A);
  static const Color white = Colors.white;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sky,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(
              child: _GameBackground(),
            ),

            Column(
              children: [
                _buildTopBar(),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      8,
                      20,
                      25,
                    ),
                    child: Column(
                      children: [
                        _buildHero(),

                        const SizedBox(height: 18),

                        _buildMissionCard(),

                        const SizedBox(height: 20),

                        _buildModeSection(),

                        const SizedBox(height: 20),

                        _buildGameSection(),

                        const SizedBox(height: 22),

                        _buildStartButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        12,
        18,
        3,
      ),
      child: Row(
        children: [
          AppBackButton(
            onTap: () => Navigator.pop(context),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Text(
              'GAME HUB',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.6,
                color: purple,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: purple.withOpacity(0.12),
              ),
            ),
            child: Text(
              'NEX ${widget.classNumber}',
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: purple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHero() {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final double scale =
                1 + (_animationController.value * 0.05);

            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFBCEBFF),
                  Color(0xFFD8D0FF),
                ],
              ),
              borderRadius: BorderRadius.circular(27),
              boxShadow: [
                BoxShadow(
                  color: purple.withOpacity(0.20),
                  blurRadius: 22,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.sports_esports_rounded,
              size: 43,
              color: purple,
            ),
          ),
        ),

        const SizedBox(height: 13),

        const Text(
          'READY TO PLAY?',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w900,
            color: dark,
            letterSpacing: 0.3,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          widget.subject.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: purple,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MISSION CARD
  // ============================================================

  Widget _buildMissionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFE4DFFF),
                  Color(0xFFD9F4FF),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.flag_rounded,
              color: purple,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MISSION',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: muted,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  widget.topicName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: dark,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1C9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.bolt_rounded,
                  size: 15,
                  color: Color(0xFFE6A329),
                ),
                SizedBox(width: 2),
                Text(
                  'XP',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFE6A329),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MODE SECTION
  // ============================================================

  Widget _buildModeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          'CHOOSE MODE',
          Icons.bolt_rounded,
        ),

        const SizedBox(height: 11),

        Row(
          children: [
            Expanded(
              child: _buildModeCard(
                type: 'learn',
                title: 'LEARN',
                icon: Icons.auto_stories_rounded,
                gradientColors: const [
                  Color(0xFFBCEBFF),
                  Color(0xFFD8F3FF),
                ],
                iconColor: const Color(0xFF55A6D4),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _buildModeCard(
                type: 'test',
                title: 'TEST',
                icon: Icons.emoji_events_rounded,
                gradientColors: const [
                  Color(0xFFFFE5B5),
                  Color(0xFFFFD1C9),
                ],
                iconColor: const Color(0xFFE29A3A),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // MODE CARD
  // ============================================================

  Widget _buildModeCard({
    required String type,
    required String title,
    required IconData icon,
    required List<Color> gradientColors,
    required Color iconColor,
  }) {
    final bool selected = selectedMode == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMode = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: 105,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: selected
                ? purple
                : const Color(0xFFE7E5ED),
            width: selected ? 2.3 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? purple.withOpacity(0.14)
                  : Colors.black.withOpacity(0.035),
              blurRadius: selected ? 18 : 9,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 49,
                    height: 49,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      icon,
                      size: 27,
                      color: iconColor,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: dark,
                      letterSpacing: 0.7,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 9,
              right: 9,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: selected
                      ? purple
                      : const Color(0xFFF0EEF5),
                  shape: BoxShape.circle,
                ),
                child: selected
                    ? const Icon(
                        Icons.check_rounded,
                        color: white,
                        size: 13,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // GAME SECTION
  // ============================================================

  Widget _buildGameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          'CHOOSE GAME ZONE',
          Icons.sports_esports_rounded,
        ),

        const SizedBox(height: 11),

        _buildGameCard(
          type: 'action',
          title: 'ACTION',
          icon: Icons.flash_on_rounded,
          gradientColors: const [
            Color(0xFFFFE2B8),
            Color(0xFFFFC6C6),
          ],
          iconColor: const Color(0xFFE98A4A),
        ),

        const SizedBox(height: 11),

        _buildGameCard(
          type: 'mystery',
          title: 'MYSTERY',
          icon: Icons.search_rounded,
          gradientColors: const [
            Color(0xFFBCEBFF),
            Color(0xFFD8D0FF),
          ],
          iconColor: purple,
        ),
      ],
    );
  }

  // ============================================================
  // GAME CARD
  // ============================================================

  Widget _buildGameCard({
    required String type,
    required String title,
    required IconData icon,
    required List<Color> gradientColors,
    required Color iconColor,
  }) {
    final bool selected = selectedGameType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGameType = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: double.infinity,
        height: 78,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: selected
                ? purple
                : const Color(0xFFE7E5ED),
            width: selected ? 2.3 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? purple.withOpacity(0.14)
                  : Colors.black.withOpacity(0.035),
              blurRadius: selected ? 18 : 9,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 53,
              height: 53,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                ),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Icon(
                icon,
                size: 29,
                color: iconColor,
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: dark,
                  letterSpacing: 0.6,
                ),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: selected
                    ? purple
                    : const Color(0xFFF0EEF5),
                shape: BoxShape.circle,
              ),
              child: selected
                  ? const Icon(
                      Icons.check_rounded,
                      color: white,
                      size: 16,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _sectionHeader(
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: purple,
        ),

        const SizedBox(width: 7),

        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: dark,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // START BUTTON
  // ============================================================

  Widget _buildStartButton() {
    final bool ready =
        selectedMode != null && selectedGameType != null;

    String text;

    if (!ready) {
      text = 'CHOOSE YOUR PATH';
    } else {
      text = 'START GAME';
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: ready ? _continueToGame : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: purple,
          foregroundColor: white,
          disabledBackgroundColor: const Color(0xFFD7D3E7),
          disabledForegroundColor: const Color(0xFF9995A7),
          elevation: ready ? 6 : 0,
          shadowColor: purple.withOpacity(0.30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              ready
                  ? Icons.play_arrow_rounded
                  : Icons.lock_open_rounded,
              size: 27,
            ),

            const SizedBox(width: 8),

            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CONTINUE
  // ============================================================

  void _continueToGame() {
  if (selectedMode == null || selectedGameType == null) {
    return;
  }

  if (selectedGameType == 'mystery') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MysteryGameScreen(
          classNumber: widget.classNumber,
          subject: widget.subject,
          topicName: widget.topicName,
          mode: selectedMode!,
        ),
      ),
    );
  }
}
}

// ==================================================================
// GAME BACKGROUND
// ==================================================================

class _GameBackground extends StatelessWidget {
  const _GameBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFEAF9FF),
                  Color(0xFFF0EDFF),
                  Color(0xFFFAF9FF),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: -70,
          right: -55,
          child: _GlowCircle(
            size: 180,
            color: const Color(0xFFD8D0FF),
          ),
        ),

        Positioned(
          top: 350,
          left: -90,
          child: _GlowCircle(
            size: 170,
            color: const Color(0xFFCDEFFF),
          ),
        ),

        Positioned(
          bottom: -90,
          right: -45,
          child: _GlowCircle(
            size: 190,
            color: const Color(0xFFE5DDFF),
          ),
        ),

        const Positioned(
          top: 135,
          left: 32,
          child: Icon(
            Icons.star_rounded,
            size: 10,
            color: Color(0xFFB8B1D8),
          ),
        ),

        const Positioned(
          top: 220,
          right: 40,
          child: Icon(
            Icons.auto_awesome_rounded,
            size: 12,
            color: Color(0xFFB7AFE0),
          ),
        ),

        const Positioned(
          bottom: 160,
          left: 30,
          child: Icon(
            Icons.star_rounded,
            size: 9,
            color: Color(0xFFB8DDE8),
          ),
        ),
      ],
    );
  }
}

// ==================================================================
// GLOW CIRCLE
// ==================================================================

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.30),
      ),
    );
  }
}
