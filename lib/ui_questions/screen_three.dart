import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({super.key});

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> with SingleTickerProviderStateMixin {
  bool _isSuccess = false;
  late AnimationController _btnController;

  @override
  void initState() {
    super.initState();
    _btnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _btnController.dispose();
    super.dispose();
  }

  void _triggerSuccess() {
    setState(() {
      _isSuccess = !_isSuccess;
    });
    if (_isSuccess) {
      _btnController.forward().then((_) => _btnController.reverse());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reliable Lottie animation URL (celebration/success checkmark)
    const lottieUrl = 'https://assets5.lottiefiles.com/packages/lf20_s2lryxtd.json';

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: Text(
          'Lottie & Animations (Q3)',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container with neon/glow decoration
                Container(
                  padding: const EdgeInsets.all(24),
                  constraints: const BoxConstraints(maxWidth: 365),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: _isSuccess ? Colors.emeraldAccent.withOpacity(0.3) : Colors.cyanAccent.withOpacity(0.15),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _isSuccess ? Colors.emeraldAccent.withOpacity(0.08) : Colors.cyanAccent.withOpacity(0.04),
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Animated box size changing based on state
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Lottie.network(
                            lottieUrl,
                            fit: BoxFit.contain,
                            repeat: true,
                            animate: _isSuccess,
                            // ErrorBuilder provides high-fidelity fallback if user is offline
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  _isSuccess ? Icons.check_circle_outline : Icons.sentiment_satisfied_alt,
                                  size: 100,
                                  color: _isSuccess ? Colors.emeraldAccent : Colors.white30,
                                ),
                              );
                            },
                            frameBuilder: (context, child, composition) {
                              if (composition == null) {
                                return const Center(
                                  child: CircularProgressIndicator(color: Colors.cyanAccent),
                                );
                              }
                              return child;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      Text(
                        _isSuccess ? 'Task Completed!' : 'Animation Playground',
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      Text(
                        _isSuccess
                            ? 'The Lottie file is now playing in an active loop. Click the button to pause it.'
                            : 'This card demonstrates Lottie package integration with network load capability, dynamic borders, and local error fallbacks.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          height: 1.5,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Animated scale button using custom InkWell and ScaleTransition
                      ScaleTransition(
                        scale: Tween<double>(begin: 1.0, end: 0.92).animate(
                          CurvedAnimation(parent: _btnController, curve: Curves.easeIn),
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: _isSuccess
                                  ? [Colors.emerald.shade600, Colors.teal.shade500]
                                  : [Colors.cyanAccent.shade700, const Color(0xFF0891B2)],
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _triggerSuccess,
                            child: Text(
                              _isSuccess ? 'Pause Animation' : 'Start Animation',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
