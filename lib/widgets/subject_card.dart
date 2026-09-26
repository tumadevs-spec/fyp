import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final String title;

  final String imagePath;
  final List<Color> colors;
  final Color iconColor;
  final VoidCallback onTap;
  final bool locked;

  const SubjectCard({
    super.key,
    required this.title,

    required this.imagePath,
    required this.colors,
    required this.iconColor,
    required this.onTap,
    this.locked = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color lightAccent =
        Color.lerp(iconColor, Colors.white, 0.78) ?? Colors.white;

    return GestureDetector(
      onTap: locked ? null : onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: locked ? 0.55 : 1,
        child: Container(
          height: 310,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: iconColor.withOpacity(0.20),
                blurRadius: 30,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: Stack(
              children: [
                // =====================================================
                // MAIN WORLD BACKGROUND
                // =====================================================

                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          colors.first,
                          colors.length > 1
                              ? colors[1]
                              : colors.first,
                          const Color(0xFFF7F5FF),
                        ],
                        stops: const [
                          0.0,
                          0.62,
                          1.0,
                        ],
                      ),
                    ),
                  ),
                ),

                // =====================================================
                // LARGE BACKGROUND ORB
                // =====================================================

                Positioned(
                  top: -90,
                  right: -75,
                  child: Container(
                    width: 210,
                    height: 210,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.28),
                    ),
                  ),
                ),

                // =====================================================
                // SECOND ORB
                // =====================================================

                Positioned(
                  bottom: -80,
                  left: -65,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.18),
                    ),
                  ),
                ),

               
              

                // =====================================================
                // ROBOT LIGHT AURA
                // =====================================================

                Positioned(
                  top: 50,
                  left: 45,
                  right: 45,
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.58),
                          Colors.white.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),

                // =====================================================
                // MAIN SUBJECT ROBOT
                // =====================================================

                Positioned(
                  top: 38,
                  left: 15,
                  right: 15,
                  child: SizedBox(
                    height: 195,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Icon(
                          Icons.smart_toy_rounded,
                          size: 105,
                          color: iconColor.withOpacity(0.4),
                        );
                      },
                    ),
                  ),
                ),

                // =====================================================
                // ROBOT GROUND LIGHT
                // =====================================================

                Positioned(
                  top: 213,
                  left: 80,
                  right: 80,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: iconColor.withOpacity(0.30),
                          blurRadius: 18,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),

                // =====================================================
                // SMALL FLOATING AI NODE
                // =====================================================

                Positioned(
                  top: 105,
                  left: 21,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.40),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.70),
                      ),
                    ),
                    child: Icon(
                      Icons.bubble_chart_rounded,
                      size: 15,
                      color: iconColor.withOpacity(0.72),
                    ),
                  ),
                ),

                // =====================================================
                // SMALL FLOATING NODE
                // =====================================================

                Positioned(
                  top: 145,
                  right: 20,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.38),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.circle,
                      size: 7,
                      color: iconColor.withOpacity(0.65),
                    ),
                  ),
                ),

                // =====================================================
                // BOTTOM HUD PANEL
                // =====================================================

                Positioned(
                  left: 13,
                  right: 13,
                  bottom: 13,
                  child: Container(
                    height: 72,
                    padding: const EdgeInsets.only(
                      left: 17,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.78),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.95),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: iconColor.withOpacity(0.10),
                          blurRadius: 18,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // -------------------------------------------------
                        // TITLE
                        // -------------------------------------------------

                        Expanded(
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.4,
                                  color: Color(0xFF302E4A),
                                ),
                              ),
                              const SizedBox(height: 3),
                             
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        // -------------------------------------------------
                        // ENTER WORLD BUTTON
                        // -------------------------------------------------

                        Container(
                          width: 51,
                          height: 51,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                iconColor,
                                lightAccent,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: iconColor.withOpacity(0.30),
                                blurRadius: 13,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Icon(
                            locked
                                ? Icons.lock_rounded
                                : Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: locked ? 21 : 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // =====================================================
                // TOP GLASS LINE
                // =====================================================

                Positioned(
                  top: 0,
                  left: 35,
                  right: 35,
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.82),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}