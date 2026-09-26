import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'game_type.dart';
import '../models/curriculum_model.dart';
import '../services/curriculum_service.dart';
import '../widgets/back_button.dart';



class LearningPathScreen extends StatefulWidget {
  final int classNumber;
  final String subject;
  final String assetPath;

  const LearningPathScreen({
    super.key,
    required this.classNumber,
    required this.subject,
    required this.assetPath,
  });

  @override
  State<LearningPathScreen> createState() => _LearningPathScreenState();
}

class _LearningPathScreenState extends State<LearningPathScreen>
    with SingleTickerProviderStateMixin {
  late Future<Curriculum> curriculumFuture;
  late AnimationController _animationController;

  // ============================================================
  // COLORS
  // ============================================================

  static const Color sky = Color(0xFFEAF9FF);
  static const Color skyBlue = Color(0xFFBCEBFF);
  static const Color blue = Color(0xFF5C9FE8);

  static const Color purple = Color(0xFF8B7CF6);
  static const Color lightPurple = Color(0xFFEAE5FF);

  static const Color dark = Color(0xFF302C49);
  static const Color muted = Color(0xFF77738A);

  static const Color white = Colors.white;

  @override
  void initState() {
    super.initState();

    curriculumFuture =
        CurriculumService.loadCurriculum(widget.assetPath);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
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
        child: FutureBuilder<Curriculum>(
          future: curriculumFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoading();
            }

            if (snapshot.hasError) {
              return _buildError(snapshot.error.toString());
            }

            if (!snapshot.hasData) {
              return _buildEmpty();
            }

            final curriculum = snapshot.data!;

            final selectedClass =
                curriculum.getClass(widget.classNumber);

            if (selectedClass == null) {
              return _buildEmpty();
            }

            final topics = selectedClass.allTopics;

            if (topics.isEmpty) {
              return _buildEmpty();
            }

            return _buildGamePage(topics);
          },
        ),
      ),
    );
  }

  // ============================================================
  // MAIN GAME PAGE
  // ============================================================

  Widget _buildGamePage(List<dynamic> topics) {
    return Stack(
      children: [
        Positioned.fill(
          child: _GameBackground(
            animation: _animationController,
          ),
        ),

        Column(
          children: [
            _buildTopBar(),

            Expanded(
              child: _buildAdventureMap(topics),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
      child: Row(
        children: [
          AppBackButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NEX ${widget.classNumber}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.6,
                    color: purple,
                    shadows: <Shadow>[],
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.subject,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: dark,
                    shadows: <Shadow>[],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: purple.withOpacity(0.10),
                  blurRadius: 16,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.bolt_rounded,
                  color: Color(0xFFFFB52E),
                  size: 18,
                ),
                SizedBox(width: 4),
               
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ADVENTURE MAP
  // ============================================================

  Widget _buildAdventureMap(List<dynamic> topics) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 40),
      children: [
       

        const SizedBox(height: 22),

        ...List.generate(
          topics.length,
          (index) {
            final topic = topics[index];

            final bool isFirst = index == 0;
            final bool isLeft = index.isEven;

            return Column(
              children: [
                _buildMissionNode(
                  topic: topic,
                  index: index,
                  unlocked: isFirst,
                  isLeft: isLeft,
                ),

                if (index < topics.length - 1)
                  _buildPathConnector(
                    isLeft: isLeft,
                  ),
              ],
            );
          },
        ),

        const SizedBox(height: 20),

        _buildEndOfJourney(),
      ],
    );
  }

  // ============================================================
  // MISSION NODE
  // ============================================================

  Widget _buildMissionNode({
    required dynamic topic,
    required int index,
    required bool unlocked,
    required bool isLeft,
  }) {
    final String topicName = _topicName(topic);

    return Align(
      alignment:
          isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          if (unlocked) {
            _showMissionReady(
              index: index,
              topicName: topicName,
            );
          } else {
            _showLockedMission(
              index: index,
              topicName: topicName,
            );
          }
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.82,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final double pulse =
                  1.0 +
                  (math.sin(
                        _animationController.value *
                            math.pi *
                            2,
                      ) *
                      0.015);

              final double scale =
                  unlocked ? pulse : 1.0;

              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: _MissionCard(
              index: index,
              title: topicName,
              unlocked: unlocked,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PATH CONNECTOR
  // ============================================================

  Widget _buildPathConnector({
    required bool isLeft,
  }) {
    return SizedBox(
      height: 80,
      child: CustomPaint(
        painter: _SimplePathPainter(
          isLeft: isLeft,
          color: purple.withOpacity(0.35),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }

  // ============================================================
  // END OF JOURNEY
  // ============================================================

  Widget _buildEndOfJourney() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: purple.withOpacity(0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: purple.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: lightPurple,
              borderRadius: BorderRadius.circular(19),
            ),
            child: const Icon(
              Icons.flag_rounded,
              color: purple,
              size: 30,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'THE QUEST CONTINUES',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              color: purple,
              shadows: <Shadow>[],
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Complete your missions to unlock the next parts of your adventure.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              fontWeight: FontWeight.w600,
              color: muted,
              shadows: <Shadow>[],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MISSION READY
  // ============================================================

  void _showMissionReady({
    required int index,
    required String topicName,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(
            22,
            12,
            22,
            28,
          ),
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1DFE8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 22),

                Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFBCEBFF),
                        Color(0xFFD8D0FF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.rocket_launch_rounded,
                    color: purple,
                    size: 38,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'MISSION READY!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: dark,
                    shadows: <Shadow>[],
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  topicName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: purple,
                    shadows: <Shadow>[],
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Your first mission is ready. Enter the world and begin your quest!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: muted,
                    shadows: <Shadow>[],
                  ),
                ),

                const SizedBox(height: 22),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                onPressed: () async {
  Navigator.pop(context);

  final selectedGameType =
      await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (_) => GameTypeSelectionScreen(
        classNumber: widget.classNumber,
        subject: widget.subject,
        topicName: topicName,
      ),
    ),
  );

  if (selectedGameType != null && mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${selectedGameType.toUpperCase()} game selected!',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purple,
                      foregroundColor: white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          size: 24,
                        ),
                        SizedBox(width: 7),
                        Text(
                          'START MISSION',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // LOCKED MISSION
  // ============================================================

  void _showLockedMission({
    required int index,
    required String topicName,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EFF5),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(
                    Icons.lock_rounded,
                    color: Color(0xFF9995A7),
                    size: 32,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'MISSION LOCKED',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: dark,
                    shadows: <Shadow>[],
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  topicName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: purple,
                    shadows: <Shadow>[],
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Complete Mission $index first to unlock this adventure.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: muted,
                    fontWeight: FontWeight.w600,
                    shadows: <Shadow>[],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightPurple,
                      foregroundColor: purple,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'GOT IT',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // TOPIC NAME
  // ============================================================

  String _topicName(dynamic topic) {
    try {
      final dynamic name = topic.name;

      if (name != null &&
          name.toString().trim().isNotEmpty) {
        return name.toString();
      }
    } catch (_) {}

    return 'Adventure Mission';
  }

  // ============================================================
  // LOADING
  // ============================================================

  Widget _buildLoading() {
    return Stack(
      children: [
        Positioned.fill(
          child: _GameBackground(
            animation: _animationController,
          ),
        ),

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                18,
                14,
                18,
                8,
              ),
              child: Row(
                children: [
                  AppBackButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(width: 12),

                  Text(
                    'NEX ${widget.classNumber}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: dark,
                      shadows: <Shadow>[],
                    ),
                  ),
                ],
              ),
            ),

            const Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: purple,
                      ),
                    ),

                    SizedBox(height: 18),

                    Text(
                      'Building your adventure...',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: dark,
                        shadows: <Shadow>[],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // ERROR
  // ============================================================

  Widget _buildError(String error) {
    return Stack(
      children: [
        Positioned.fill(
          child: _GameBackground(
            animation: _animationController,
          ),
        ),

        Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cloud_off_rounded,
                    size: 55,
                    color: purple,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Adventure Map Error',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: dark,
                      shadows: <Shadow>[],
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'We could not load this adventure.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: muted,
                      shadows: <Shadow>[],
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        curriculumFuture =
                            CurriculumService
                                .loadCurriculum(
                          widget.assetPath,
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purple,
                      foregroundColor: white,
                      elevation: 0,
                    ),
                    child: const Text(
                      'TRY AGAIN',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // EMPTY
  // ============================================================

  Widget _buildEmpty() {
    return Stack(
      children: [
        Positioned.fill(
          child: _GameBackground(
            animation: _animationController,
          ),
        ),

        Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 58,
                    color: purple,
                  ),

                  SizedBox(height: 16),

                  Text(
                    'No Missions Yet',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: dark,
                      shadows: <Shadow>[],
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Your adventure map is waiting for new missions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: muted,
                      shadows: <Shadow>[],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =================================================================
// MISSION CARD
// =================================================================

class _MissionCard extends StatelessWidget {
  final int index;
  final String title;
  final bool unlocked;

  const _MissionCard({
    required this.index,
    required this.title,
    required this.unlocked,
  });

  // Local colors because this is a separate class.
  static const Color cardWhite = Colors.white;
  static const Color cardPurple = Color(0xFF8B7CF6);
  static const Color cardLightPurple = Color(0xFFEAE5FF);
  static const Color cardDark = Color(0xFF302C49);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: unlocked
              ? cardPurple.withOpacity(0.18)
              : const Color(0xFFE8E6EF),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: unlocked
                ? cardPurple.withOpacity(0.13)
                : Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          // ======================================================
          // CHECKPOINT ICON
          // ======================================================

          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: unlocked
                    ? const [
                        Color(0xFFBCEBFF),
                        Color(0xFFD8D0FF),
                      ]
                    : const [
                        Color(0xFFECEBF1),
                        Color(0xFFE2E0E8),
                      ],
              ),
              borderRadius: BorderRadius.circular(21),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  unlocked
                      ? Icons.rocket_launch_rounded
                      : Icons.lock_rounded,
                  size: 28,
                  color: unlocked
                      ? cardPurple
                      : const Color(0xFF9995A7),
                ),

                if (unlocked)
                  Positioned(
                    top: 5,
                    right: 6,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFB52E),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 13),

          // ======================================================
          // TEXT
          // ======================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  unlocked
                      ? 'STARTING MISSION'
                      : 'MISSION ${index + 1}',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                    color: unlocked
                        ? cardPurple
                        : const Color(0xFF9995A7),
                    shadows: const <Shadow>[],
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    color: cardDark,
                    shadows: <Shadow>[],
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  unlocked
                      ? 'READY TO PLAY'
                      : 'UNLOCK AFTER PREVIOUS',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: unlocked
                        ? const Color(0xFF6AA879)
                        : const Color(0xFFA4A1AE),
                    shadows: const <Shadow>[],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ======================================================
          // ARROW / LOCK
          // ======================================================

          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: unlocked
                  ? cardLightPurple
                  : const Color(0xFFF1F0F4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              unlocked
                  ? Icons.arrow_forward_rounded
                  : Icons.lock_rounded,
              size: 18,
              color: unlocked
                  ? cardPurple
                  : const Color(0xFFA4A1AE),
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// MAP PATH
// =================================================================

class _SimplePathPainter extends CustomPainter {
  final bool isLeft;
  final Color color;

  _SimplePathPainter({
    required this.isLeft,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double startX = isLeft
        ? size.width * 0.30
        : size.width * 0.70;

    final double endX = isLeft
        ? size.width * 0.70
        : size.width * 0.30;

    const int steps = 40;

    for (int i = 0; i < steps; i++) {
      if (i.isOdd) {
        continue;
      }

      final double t1 = i / steps;
      final double t2 =
          math.min((i + 0.8) / steps, 1.0);

      final Offset p1 = _cubicPoint(
        t1,
        Offset(startX, 0),
        Offset(startX, size.height * 0.40),
        Offset(endX, size.height * 0.60),
        Offset(endX, size.height),
      );

      final Offset p2 = _cubicPoint(
        t2,
        Offset(startX, 0),
        Offset(startX, size.height * 0.40),
        Offset(endX, size.height * 0.60),
        Offset(endX, size.height),
      );

      canvas.drawLine(
        p1,
        p2,
        paint,
      );
    }

    // Small decorative stars
    final starPaint = Paint()
      ..color = color.withOpacity(0.55)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(
        size.width * 0.48,
        size.height * 0.35,
      ),
      2.5,
      starPaint,
    );

    canvas.drawCircle(
      Offset(
        size.width * 0.55,
        size.height * 0.68,
      ),
      2,
      starPaint,
    );
  }

  Offset _cubicPoint(
    double t,
    Offset p0,
    Offset p1,
    Offset p2,
    Offset p3,
  ) {
    final double u = 1.0 - t;

    final double x =
        (u * u * u * p0.dx) +
        (3.0 * u * u * t * p1.dx) +
        (3.0 * u * t * t * p2.dx) +
        (t * t * t * p3.dx);

    final double y =
        (u * u * u * p0.dy) +
        (3.0 * u * u * t * p1.dy) +
        (3.0 * u * t * t * p2.dy) +
        (t * t * t * p3.dy);

    return Offset(x, y);
  }

  @override
  bool shouldRepaint(
    covariant _SimplePathPainter oldDelegate,
  ) {
    return oldDelegate.isLeft != isLeft ||
        oldDelegate.color != color;
  }
}

// =================================================================
// GAME BACKGROUND
// =================================================================

class _GameBackground extends StatelessWidget {
  final Animation<double> animation;

  const _GameBackground({
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final double value =
            math.sin(animation.value * math.pi * 2);

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
              top: -70 + value * 8,
              right: -55,
              child: const _GlowCircle(
                size: 180,
                color: Color(0xFFD8D0FF),
              ),
            ),

            Positioned(
              top: 220 + value * 10,
              left: -85,
              child: const _GlowCircle(
                size: 170,
                color: Color(0xFFCDEFFF),
              ),
            ),

            Positioned(
              bottom: -80,
              right: -40,
              child: const _GlowCircle(
                size: 190,
                color: Color(0xFFE5DDFF),
              ),
            ),

            const Positioned(
              top: 130,
              left: 35,
              child: Icon(
                Icons.star_rounded,
                size: 10,
                color: Color(0xFFB8B1D8),
              ),
            ),

            const Positioned(
              top: 185,
              right: 65,
              child: Icon(
                Icons.star_rounded,
                size: 8,
                color: Color(0xFFA9DDF2),
              ),
            ),

            const Positioned(
              top: 390,
              left: 70,
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 11,
                color: Color(0xFFB7AFE0),
              ),
            ),

            const Positioned(
              bottom: 180,
              right: 35,
              child: Icon(
                Icons.star_rounded,
                size: 9,
                color: Color(0xFFA9DDF2),
              ),
            ),
          ],
        );
      },
    );
  }
}

// =================================================================
// GLOW CIRCLE
// =================================================================

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
        color: color.withOpacity(0.32),
      ),
    );
  }
}