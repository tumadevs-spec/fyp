import 'package:flutter/material.dart';

import '../widgets/subject_card.dart';
import 'learning_path_screen.dart';

class SubjectScreen extends StatelessWidget {
  final int classNumber;

  const SubjectScreen({
    super.key,
    required this.classNumber,
  });

  // ============================================================
  // COLORS
  // ============================================================

  static const Color background = Color(0xFFF7F8FC);
  static const Color darkText = Color(0xFF302C49);
  static const Color mutedText = Color(0xFF706B82);
  static const Color softPurple = Color(0xFF8B7CF6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            // ====================================================
            // TOP BAR
            // ====================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                16,
                20,
                8,
              ),
              child: Row(
                children: [
                  // BACK BUTTON
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: darkText,
                        size: 22,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // TITLE
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NEX $classNumber',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            color: Color(0xFF8B86A4),
                            shadows: <Shadow>[],
                          ),
                        ),

                        const SizedBox(height: 3),

                        const Text(
                          'Choose Your World',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w900,
                            color: darkText,
                            height: 1,
                            shadows: <Shadow>[],
                          ),
                        ),
                      ],
                    ),
                  ),

               
                ],
              ),
            ),

            // ====================================================
            // INTRO
            // ====================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                14,
                20,
                18,
              ),
              child: Row(
                children: [
                  // PURPLE ACCENT LINE
                  Container(
                    width: 5,
                    height: 35,
                    decoration: BoxDecoration(
                      color: softPurple,
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(width: 11),

                  const Expanded(
                    child: Text(
                      'Pick an adventure, enter the world, '
                      'and start your mission!',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        fontWeight: FontWeight.w600,
                        color: mutedText,
                        shadows: <Shadow>[],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ====================================================
            // WORLDS
            // ====================================================

            Expanded(
              child: ListView(
                physics:
                    const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  30,
                ),
                children: [
                  // ==================================================
                  // FUTURE WORLD
                  // ==================================================

                  SubjectCard(
                    title: 'Future World',
                   
                    imagePath:
                        'assets/images/subjects/computer_robot.png',
                    colors: const [
                      Color(0xFFDDF5FF),
                      Color(0xFFBCEBFF),
                    ],
                    iconColor:
                        Color(0xFF5C9FE8),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              LearningPathScreen(
                            classNumber:
                                classNumber,
                            subject:
                                'Future World',
                            assetPath:
                                'assets/curriculum/computer_science.json',
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // MIND & ME
                  // ==================================================

                  SubjectCard(
                    title: 'Mind & Me',
                  
                    imagePath:
                        'assets/images/subjects/wellbeing_robot.png',
                    colors: const [
                      Color(0xFFEAE5FF),
                      Color(0xFFD8D0FF),
                    ],
                    iconColor:
                        Color(0xFF8B7CF6),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              LearningPathScreen(
                            classNumber:
                                classNumber,
                            subject:
                                'Mind & Me',
                            assetPath:
                                'assets/curriculum/wellbeing_curriculum.json',
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // ==================================================
                  // COMING SOON
                  // ==================================================

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(20),
                      border: Border.all(
                        color:
                            const Color(0xFFE9E7F2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFF0EDFF,
                            ),
                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                          ),
                          child: const Icon(
                            Icons.auto_awesome_rounded,
                            size: 19,
                            color: softPurple,
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'More worlds are coming...',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight.w800,
                                  color: darkText,
                                  shadows:
                                      <Shadow>[],
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'New adventures will unlock soon.',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight:
                                      FontWeight.w500,
                                  color: mutedText,
                                  shadows:
                                      <Shadow>[],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.lock_outline_rounded,
                          size: 18,
                          color: Color(0xFFAAA6BA),
                        ),
                      ],
                    ),
                  ),

              

                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}