import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _subtitleController;
  late AnimationController _ballController;
  late AnimationController _loadingController;
  late AnimationController _zoomController;
  late AnimationController _progressController;

  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _subtitleFadeAnimation;
  late Animation<Offset> _subtitleSlideAnimation;
  late Animation<double> _ballScaleAnimation;
  late Animation<double> _ballFadeAnimation;
  late Animation<double> _loadingFadeAnimation;
  late Animation<double> _zoomAnimation;
  late Animation<double> _zoomFadeAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _subtitleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _ballController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _zoomController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    // Create animations
    _titleFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut));

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut));

    _subtitleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _subtitleController, curve: Curves.easeOut),
    );

    _subtitleSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _subtitleController, curve: Curves.easeOut),
        );

    _ballScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ballController, curve: Curves.easeOut));

    _ballFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ballController, curve: Curves.easeOut));

    _loadingFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.easeOutCubic),
    );

    _zoomAnimation = Tween<double>(begin: 1.0, end: 3.0).animate(
      CurvedAnimation(parent: _zoomController, curve: Curves.easeInOut),
    );

    _zoomFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _zoomController, curve: Curves.easeInOut),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    // Start progress animation
    _progressController.forward();

    // Start title animation
    _titleController.forward();

    // Start subtitle animation after delay
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) _subtitleController.forward();

    // Start ball animation after delay
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) _ballController.forward();

    // Start loading animation after delay
    await Future.delayed(const Duration(milliseconds: 700));
    if (mounted) _loadingController.forward();

    // Wait for splash to display for 5.5 seconds total
    await Future.delayed(const Duration(milliseconds: 4100));
    if (mounted) {
      // Start zoom-in animation
      await _zoomController.forward();
      // Navigate to login page
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  int _getProgressPercentage(double progress) {
    if (progress < 0.1) {
      return (progress * 80).round(); // 0% to 8%
    } else if (progress < 0.25) {
      return (8 + ((progress - 0.1) * 47)).round(); // 8% to 15%
    } else if (progress < 0.4) {
      return (15 + ((progress - 0.25) * 133)).round(); // 15% to 35%
    } else if (progress < 0.55) {
      return (35 + ((progress - 0.4) * 67)).round(); // 35% to 45%
    } else if (progress < 0.7) {
      return (45 + ((progress - 0.55) * 133)).round(); // 45% to 65%
    } else if (progress < 0.85) {
      return (65 + ((progress - 0.7) * 100)).round(); // 65% to 80%
    } else if (progress < 0.95) {
      return (80 + ((progress - 0.85) * 100)).round(); // 80% to 90%
    } else {
      return (90 + ((progress - 0.95) * 200)).round(); // 90% to 100%
    }
  }

  double _getProgressValue(double progress) {
    if (progress < 0.1) {
      return progress * 0.8; // 0% to 8%
    } else if (progress < 0.25) {
      return 0.08 + ((progress - 0.1) * 0.467); // 8% to 15%
    } else if (progress < 0.4) {
      return 0.15 + ((progress - 0.25) * 1.33); // 15% to 35%
    } else if (progress < 0.55) {
      return 0.35 + ((progress - 0.4) * 0.67); // 35% to 45%
    } else if (progress < 0.7) {
      return 0.45 + ((progress - 0.55) * 1.33); // 45% to 65%
    } else if (progress < 0.85) {
      return 0.65 + ((progress - 0.7) * 1.0); // 65% to 80%
    } else if (progress < 0.95) {
      return 0.80 + ((progress - 0.85) * 1.0); // 80% to 90%
    } else {
      return 0.90 + ((progress - 0.95) * 2.0); // 90% to 100%
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _ballController.dispose();
    _loadingController.dispose();
    _zoomController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _zoomFadeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _zoomFadeAnimation.value,
            child: Transform.scale(
              scale: _zoomAnimation.value,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFF8FAFC),
                      Color(0xFF3B82F6),
                    ],
                    stops: [0.0, 0.6, 1.0],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 60,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo with fade and slide animation
                        FadeTransition(
                          opacity: _ballFadeAnimation,
                          child: ScaleTransition(
                            scale: _ballScaleAnimation,
                            child: Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(0.3),
                                    Colors.white.withOpacity(0.1),
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF3B82F6,
                                    ).withOpacity(0.2),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Image.asset(
                                    'assets/images/alchemy.jpg',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF3B82F6),
                                        ),
                                        child: const Icon(
                                          Icons.auto_fix_high,
                                          color: Colors.white,
                                          size: 80,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 50),

                        // Title with slide animation
                        FadeTransition(
                          opacity: _titleFadeAnimation,
                          child: SlideTransition(
                            position: _titleSlideAnimation,
                            child: const Text(
                              'Alchemy',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F2937),
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Subtitle with slide animation
                        FadeTransition(
                          opacity: _subtitleFadeAnimation,
                          child: SlideTransition(
                            position: _subtitleSlideAnimation,
                            child: const Text(
                              'Transform your photos with AI magic',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF3B82F6),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Ball Playing Animation
                        FadeTransition(
                          opacity: _ballFadeAnimation,
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: Lottie.asset(
                              'assets/animations/ball_playing.json',
                              repeat: true,
                              reverse: false,
                              animate: true,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Progress bar
                        FadeTransition(
                          opacity: _loadingFadeAnimation,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 8,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: AnimatedBuilder(
                                  animation: _progressAnimation,
                                  builder: (context, child) {
                                    double progressValue = _getProgressValue(
                                      _progressAnimation.value,
                                    );

                                    return FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: progressValue,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xFF3B82F6),
                                              Color(0xFF60A5FA),
                                              Color(0xFF93C5FD),
                                            ],
                                            stops: [0.0, 0.6, 1.0],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(
                                                0xFF3B82F6,
                                              ).withOpacity(0.6),
                                              blurRadius: 12,
                                              offset: const Offset(0, 3),
                                              spreadRadius: 1,
                                            ),
                                            BoxShadow(
                                              color: Colors.white.withOpacity(
                                                0.3,
                                              ),
                                              blurRadius: 6,
                                              offset: const Offset(0, -2),
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              AnimatedBuilder(
                                animation: _progressAnimation,
                                builder: (context, child) {
                                  int displayProgress = _getProgressPercentage(
                                    _progressAnimation.value,
                                  );

                                  return Text(
                                    'Loading... $displayProgress%',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF3B82F6),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
