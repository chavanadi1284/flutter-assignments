import 'package:flutter/material.dart';
import 'notes_app/presentation/screens/notes_list_screen.dart';
import 'calculator/screens/calculator_screen.dart';
import 'ui_questions/questions_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FLUTTER ASSIGNMENTS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            color: Colors.cyanAccent.shade100,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Evaluation Hub',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: const Icon(
                        Icons.school_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Select any assignment to inspect UI and functional logic.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 32),

                // Assignments Grid/List
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildAssignmentCard(
                        context,
                        title: 'Notes CRUD Application',
                        subtitle: 'State Management & Architecture',
                        description: 'A notes app with list, create, and update logic. One key operation (Delete) is intentionally left unimplemented in the data/domain layer for exam testing.',
                        marks: '75 MARKS',
                        icon: Icons.note_alt_outlined,
                        color: const Color(0xFF6C63FF),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotesListScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildAssignmentCard(
                        context,
                        title: 'Calculator UI Implementation',
                        subtitle: 'Responsive Layouts & Input Logic',
                        description: 'A premium, modern calculator UI with glassmorphic elements and full mathematical evaluation logic supporting common operations.',
                        marks: '75 MARKS',
                        icon: Icons.calculate_outlined,
                        color: const Color(0xFF00B4DB),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CalculatorScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildAssignmentCard(
                        context,
                        title: '3 UI Implementation Questions',
                        subtitle: 'Core Widgets & Dynamic Animations',
                        description: 'Three distinct UI challenges testing Layouts (Row/Column/SizedBox/Padding), Grid Layout, Hero & Lottie Animations, and Custom Styling.',
                        marks: '25 MARKS × 3',
                        icon: Icons.widgets_outlined,
                        color: const Color(0xFF00F260),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuestionsHomeScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Footer info
                Center(
                  child: Text(
                    'Developed with ❤️ in Flutter',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5),
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

  Widget _buildAssignmentCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    required String marks,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: color.withOpacity(0.15),
            highlightColor: color.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: color.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          marks,
                          style: TextStyle(
                            color: color,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Icon(
                        icon,
                        color: color,
                        size: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.cyanAccent.shade100.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: Colors.white.withOpacity(0.65),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Launch Assignment',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: color,
                      ),
                    ],
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
