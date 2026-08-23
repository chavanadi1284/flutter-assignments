import 'package:flutter/material.dart';
import 'screen_one.dart';
import 'screen_two.dart';
import 'screen_three.dart';

class QuestionsHomeScreen extends StatelessWidget {
  const QuestionsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          '3 UI Questions',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UI WIDGET EVALUATION',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.cyanAccent.shade100,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Practical Showcase',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'These three tasks satisfy the 25 Marks × 3 evaluation requirement covering core widgets, animations, layout builders, and Google Fonts.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.white.withOpacity(0.65),
                ),
              ),
              const SizedBox(height: 32),

              // The three items
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildQuestionItem(
                      context,
                      number: '1',
                      title: 'Layout & Styling Card',
                      subtitle: 'Column, Row, SizedBox, Padding, Container, GoogleFonts',
                      description: 'A beautiful profile resume card with intricate details, border decoration, drop shadows, nested rows/columns, and custom typography.',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScreenOne()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildQuestionItem(
                      context,
                      number: '2',
                      title: 'Grid & Hero Animation',
                      subtitle: 'Grid Layout, Navigation, Icons, Hero transition',
                      description: 'A responsive travel card gallery. Tapping on a card navigates to a details screen via Navigator, with a Hero image expansion animation.',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScreenTwo()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildQuestionItem(
                      context,
                      number: '3',
                      title: 'Lottie & Micro-Animations',
                      subtitle: 'Lottie Animations, Animated Containers, Rich Shapes',
                      description: 'An onboarding/success showcase playing smooth Lottie animations loaded from network JSON, featuring dynamic scale buttons.',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScreenThree()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionItem(
    BuildContext context, {
    required String number,
    required String title,
    required String subtitle,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.cyanAccent.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
                    ),
                    child: Center(
                      child: Text(
                        number,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent.shade100.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: const [
                            Text(
                              'View Solution',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: 16,
                              color: Colors.cyanAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
