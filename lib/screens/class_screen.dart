import 'package:flutter/material.dart';
import 'subject_screen.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  static const Color blue = Color(0xFFBCEBFF);
  static const Color blueDark = Color(0xFF83D5F2);
  static const Color purple = Color(0xFFD9D1FF);
  static const Color purpleDark = Color(0xFFB8ADF2);
  static const Color dark = Color(0xFF46476F);
  static const Color soft = Color(0xFF77789D);

  final List<String> levelNames = [
    'STARTER',
    'PLAYER',
    'RISING STAR',
    'PRO PLAYER',
    'SUPER PLAYER',
    'CHAMPION',
  ];

  final List<String> descriptions = [
    "Let's begin!",
    'Ready to play?',
    'Level up!',
    'Show your skills!',
    'Take the challenge!',
    'Reach the top!',
  ];

  final List<IconData> icons = [
    Icons.rocket_launch_rounded,
    Icons.sports_esports_rounded,
    Icons.auto_awesome_rounded,
    Icons.bolt_rounded,
    Icons.workspace_premium_rounded,
    Icons.emoji_events_rounded,
  ];

  void _openLevel(int level) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SubjectScreen(
          classNumber: level,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FF),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFEAF8FF),
              Color(0xFFF3F0FF),
              Color(0xFFF9F8FF),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isWide = constraints.maxWidth > 700;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 70 : 20,
                    vertical: 18,
                  ),
                  child: Column(
                    children: [
                      _buildTopBar(),
                      const SizedBox(height: 24),
                      _buildHeader(),
                      const SizedBox(height: 22),
                      _buildGameMap(isWide),
                      const SizedBox(height: 22),
                      _buildBottomHint(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.72),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.9),
              ),
              boxShadow: [
                BoxShadow(
                  color: purpleDark.withOpacity(0.14),
                  blurRadius: 16,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: dark,
              size: 22,
            ),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.smart_toy_rounded,
                color: purpleDark,
                size: 18,
              ),
              SizedBox(width: 7),
              Text(
                'NEXLEARN',
                style: TextStyle(
                  color: dark,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Column(
      children: [
        
        const SizedBox(height: 13),
        const Text(
          'CHOOSE YOUR PATH',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: dark,
            fontSize: 27,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Pick a level and start playing.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: soft,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // GAME MAP
  // ============================================================

  Widget _buildGameMap(bool isWide) {
    final double mapHeight = isWide ? 650 : 820;

    return Container(
      height: mapHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE8F8FF),
            Color(0xFFF0EEFF),
            Color(0xFFEFF9FF),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.95),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: purpleDark.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background glow
          Positioned(
            top: -100,
            left: -80,
            child: _glow(
              250,
              blue.withOpacity(0.38),
            ),
          ),

          Positioned(
            bottom: -100,
            right: -80,
            child: _glow(
              260,
              purple.withOpacity(0.38),
            ),
          ),

          // Decorative dots
          ..._buildMapDots(),

          // Winding game path
          Positioned.fill(
            child: CustomPaint(
              painter: GamePathPainter(),
            ),
          ),

          // Level portals
          ..._buildLevelNodes(isWide),

          // Start label
          Positioned(
            top: 24,
            left: 24,
            child: _mapLabel(
              Icons.flag_rounded,
              'START',
              blueDark,
            ),
          ),

          // Finish label
          Positioned(
            bottom: 25,
            right: 24,
            child: _mapLabel(
              Icons.emoji_events_rounded,
              'FINISH',
              purpleDark,
            ),
          ),

          // Robot
          Positioned(
            left: isWide ? 25 : 12,
            bottom: 75,
            child: _buildPlayerRobot(),
          ),
        ],
      ),
    );
  }

  Widget _glow(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  // ============================================================
  // MAP DOTS
  // ============================================================

  List<Widget> _buildMapDots() {
    return [
      Positioned(
        left: 70,
        top: 100,
        child: _dot(8),
      ),
      Positioned(
        left: 125,
        top: 165,
        child: _dot(5),
      ),
      Positioned(
        right: 70,
        top: 95,
        child: _dot(7),
      ),
      Positioned(
        right: 120,
        top: 210,
        child: _dot(5),
      ),
      Positioned(
        left: 45,
        bottom: 210,
        child: _dot(6),
      ),
      Positioned(
        right: 50,
        bottom: 150,
        child: _dot(8),
      ),
      Positioned(
        left: 170,
        bottom: 70,
        child: _dot(5),
      ),
    ];
  }

  Widget _dot(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }

  // ============================================================
  // LEVEL NODES
  // ============================================================

  List<Widget> _buildLevelNodes(bool isWide) {
    if (isWide) {
      return [
        _positionedNode(
          level: 1,
          left: 90,
          top: 90,
        ),
        _positionedNode(
          level: 2,
          right: 100,
          top: 175,
        ),
        _positionedNode(
          level: 3,
          left: 170,
          top: 285,
        ),
        _positionedNode(
          level: 4,
          right: 110,
          top: 390,
        ),
        _positionedNode(
          level: 5,
          left: 90,
          top: 475,
        ),
        _positionedNode(
          level: 6,
          right: 70,
          top: 545,
        ),
      ];
    }

    return [
      _positionedNode(
        level: 1,
        left: 45,
        top: 80,
      ),
      _positionedNode(
        level: 2,
        right: 42,
        top: 190,
      ),
      _positionedNode(
        level: 3,
        left: 55,
        top: 315,
      ),
      _positionedNode(
        level: 4,
        right: 45,
        top: 435,
      ),
      _positionedNode(
        level: 5,
        left: 50,
        top: 555,
      ),
      _positionedNode(
        level: 6,
        right: 50,
        top: 670,
      ),
    ];
  }

  Widget _positionedNode({
    required int level,
    double? left,
    double? right,
    required double top,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: GestureDetector(
        onTap: () => _openLevel(level),
        child: _buildLevelNode(level),
      ),
    );
  }

  Widget _buildLevelNode(int level) {
    final int index = level - 1;

    final List<List<Color>> gradients = [
      [
        const Color(0xFFFFFFFF),
        const Color(0xFFC7F0FF),
      ],
      [
        const Color(0xFFFFFFFF),
        const Color(0xFFD7D0FF),
      ],
      [
        const Color(0xFFFFFFFF),
        const Color(0xFFBEEAFF),
      ],
      [
        const Color(0xFFFFFFFF),
        const Color(0xFFD9D0FF),
      ],
      [
        const Color(0xFFFFFFFF),
        const Color(0xFFBFEAFF),
      ],
      [
        const Color(0xFFFFFFFF),
        const Color(0xFFCFC5FF),
      ],
    ];

    return SizedBox(
      width: 155,
      child: Column(
        children: [
          // ======================================================
          // LEVEL PORTAL
          // ======================================================

          Container(
            width: 102,
            height: 102,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradients[index],
              ),
              border: Border.all(
                color: Colors.white,
                width: 5,
              ),
              boxShadow: [
                BoxShadow(
                  color: purpleDark.withOpacity(0.22),
                  blurRadius: 22,
                  spreadRadius: 3,
                  offset: const Offset(0, 9),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Inner ring
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.8),
                      width: 2,
                    ),
                  ),
                ),

                // Level number
                Text(
                  level.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    color: dark,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),

                // Icon
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icons[index],
                      size: 15,
                      color: dark,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 9),

          // ======================================================
          // LEVEL LABEL
          // ======================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.82),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: Colors.white,
              ),
              boxShadow: [
                BoxShadow(
                  color: purpleDark.withOpacity(0.09),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'LEVEL ${level.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: soft,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  levelNames[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: dark,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  descriptions[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: soft,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
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
  // MAP LABEL
  // ============================================================

  Widget _mapLabel(
    IconData icon,
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.72),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: dark,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ROBOT
  // ============================================================

  Widget _buildPlayerRobot() {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.55),
        boxShadow: [
          BoxShadow(
            color: blueDark.withOpacity(0.22),
            blurRadius: 20,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          'assets/images/robot.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM HINT
  // ============================================================

  Widget _buildBottomHint() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.68),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.9),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.touch_app_rounded,
            color: purpleDark,
            size: 19,
          ),
          SizedBox(width: 9),
          Text(
            'Tap a portal to enter the level',
            style: TextStyle(
              color: dark,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// GAME MAP PATH
// ================================================================

class GamePathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // ------------------------------------------------------------
    // Shadow
    // ------------------------------------------------------------

    final Paint shadowPaint = Paint()
      ..color = const Color(0xFF9D97C9).withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    // ------------------------------------------------------------
    // White outer path
    // ------------------------------------------------------------

    final Paint outerPaint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 21
      ..strokeCap = StrokeCap.round;

    // ------------------------------------------------------------
    // Main path
    // ------------------------------------------------------------

    final Paint pathPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFAEDFF4),
          Color(0xFFC6BDF0),
          Color(0xFFB4E3F6),
          Color(0xFFC6BDF0),
        ],
      ).createShader(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13
      ..strokeCap = StrokeCap.round;

    // ------------------------------------------------------------
    // Winding path
    // ------------------------------------------------------------

    final Path path = Path();

    // Start
    path.moveTo(
      size.width * 0.26,
      size.height * 0.16,
    );

    // Curve 1
    path.cubicTo(
      size.width * 0.78,
      size.height * 0.20,
      size.width * 0.82,
      size.height * 0.27,
      size.width * 0.70,
      size.height * 0.34,
    );

    // Curve 2
    path.cubicTo(
      size.width * 0.55,
      size.height * 0.42,
      size.width * 0.24,
      size.height * 0.38,
      size.width * 0.28,
      size.height * 0.51,
    );

    // Curve 3
    path.cubicTo(
      size.width * 0.32,
      size.height * 0.64,
      size.width * 0.78,
      size.height * 0.53,
      size.width * 0.74,
      size.height * 0.67,
    );

    // Curve 4
    path.cubicTo(
      size.width * 0.69,
      size.height * 0.78,
      size.width * 0.31,
      size.height * 0.72,
      size.width * 0.30,
      size.height * 0.87,
    );

    // Finish
    path.cubicTo(
      size.width * 0.30,
      size.height * 0.92,
      size.width * 0.61,
      size.height * 0.91,
      size.width * 0.70,
      size.height * 0.91,
    );

    // ------------------------------------------------------------
    // Draw path
    // ------------------------------------------------------------

    canvas.drawPath(
      path,
      shadowPaint,
    );

    canvas.drawPath(
      path,
      outerPaint,
    );

    canvas.drawPath(
      path,
      pathPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}