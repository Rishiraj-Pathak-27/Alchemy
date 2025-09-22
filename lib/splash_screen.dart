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
  late AnimationController _progressController;
  late AnimationController _logoController;
  late AnimationController _zoomController;
  late AnimationController _ballController;

  late Animation<double> _titleAnimation;
  late Animation<double> _subtitleAnimation;
  late Animation<double> _progressAnimation;
  late Animation<double> _logoAnimation;
  late Animation<double> _zoomAnimation;

  double _currentProgress = 0.1;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _subtitleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _progressController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _zoomController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _ballController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Initialize animations with proper clamps
    _titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.bounceOut),
    );

    _subtitleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _subtitleController, curve: Curves.easeInOut),
    );

    _progressAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _zoomAnimation = Tween<double>(begin: 1.0, end: 5.0).animate(
      CurvedAnimation(parent: _zoomController, curve: Curves.easeInOut),
    );

    // Start animations
    _startAnimations();
    _startProgressUpdates();
    _navigateToLogin();
  }

  void _startAnimations() {
    // Wait for Flutter logo to finish, then start our animations
    // Logo animation starts after Flutter logo delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) _logoController.forward();
    });

    // Ball animation starts with more delay
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) _ballController.forward();
    });

    // Title animation with proper delay
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) _titleController.forward();
    });

    // Subtitle animation
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) _subtitleController.forward();
    });
  }

  void _startProgressUpdates() {
    // Start progress after Flutter logo delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) _progressController.forward();
    });

    // Gradually increase progress from 10% to 100% over 8 seconds
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) setState(() => _currentProgress = 0.20);
    });
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) setState(() => _currentProgress = 0.35);
    });
    Future.delayed(const Duration(milliseconds: 4000), () {
      if (mounted) setState(() => _currentProgress = 0.50);
    });
    Future.delayed(const Duration(milliseconds: 5000), () {
      if (mounted) setState(() => _currentProgress = 0.65);
    });
    Future.delayed(const Duration(milliseconds: 6000), () {
      if (mounted) setState(() => _currentProgress = 0.80);
    });
    Future.delayed(const Duration(milliseconds: 7000), () {
      if (mounted) setState(() => _currentProgress = 0.95);
    });
    Future.delayed(const Duration(milliseconds: 8000), () {
      if (mounted) setState(() => _currentProgress = 1.0);
    });
  }

  void _navigateToLogin() {
    // Start zoom animation after all animations complete (8.5 seconds)
    Future.delayed(const Duration(milliseconds: 8500), () {
      if (mounted) {
        _zoomController.forward();
      }
    });

    // Navigate to login after zoom completes (10 seconds total)
    Future.delayed(const Duration(milliseconds: 10000), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _progressController.dispose();
    _logoController.dispose();
    _zoomController.dispose();
    _ballController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _zoomAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _zoomAnimation.value,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1E3A8A), // Deep blue
                    Color(0xFF3B82F6), // Blue
                    Color(0xFF60A5FA), // Light blue
                    Colors.white,
                  ],
                  stops: [0.0, 0.4, 0.7, 1.0],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Top spacing
                    const SizedBox(height: 60),

                    // Logo with animation
                    AnimatedBuilder(
                      animation: _logoAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _logoAnimation.value,
                          child: Opacity(
                            opacity: _logoAnimation.value.clamp(0.0, 1.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.auto_fix_high,
                                      size: 50,
                                      color: Color(0xFF1E3A8A),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // Ball Playing Lottie Animation
                    SizedBox(
                      width: 350,
                      height: 200,
                      child: Lottie.asset(
                        'assets/animations/ball_playing.json',
                        controller: _ballController,
                        repeat: true,
                        reverse: false,
                        animate: true,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFF3B82F6), Color(0xFF1E3A8A)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  blurRadius: 15,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.sports_basketball,
                              size: 60,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Animated Title
                    AnimatedBuilder(
                      animation: _titleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _titleAnimation.value,
                          child: Opacity(
                            opacity: _titleAnimation.value.clamp(0.0, 1.0),
                            child: const Text(
                              "IOS to android Alchemy",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E3A8A),
                                letterSpacing: 2,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Animated Subtitle
                    AnimatedBuilder(
                      animation: _subtitleAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            0,
                            20 * (1 - _subtitleAnimation.value),
                          ),
                          child: Opacity(
                            opacity: _subtitleAnimation.value.clamp(0.0, 1.0),
                            child: const Text(
                              "Capture & Enhance the image through AI",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF1E3A8A),
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),

                    const Spacer(),

                    // Progress Bar Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          // Progress Bar
                          Container(
                            width: double.infinity,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child: AnimatedBuilder(
                              animation: _progressAnimation,
                              builder: (context, child) {
                                return LinearProgressIndicator(
                                  value: _currentProgress,
                                  backgroundColor: Colors.transparent,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Color(0xFF1E3A8A),
                                      ),
                                  borderRadius: BorderRadius.circular(10),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Progress Percentage
                          AnimatedBuilder(
                            animation: _progressAnimation,
                            builder: (context, child) {
                              return Text(
                                "${(_currentProgress * 100).toInt()}%",
                                style: const TextStyle(
                                  color: Color(0xFF1E3A8A),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          // Loading Text
                          const Text(
                            "Loading your creative tools...",
                            style: TextStyle(
                              color: Color(0xFF1E3A8A),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
