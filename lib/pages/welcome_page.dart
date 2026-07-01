import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double _widthFactor = 0.0;
  bool _showButton = false;
  // List bintang untuk efek kedip
  final List<Widget> _stars = List.generate(
    25,
    (index) => const TwinklingStar(),
  );

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() => _widthFactor = 1.0);
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    setState(() => _showButton = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gambar Utama
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // 2. Bintang Berkedip (Overlay)
          ..._stars,

          // 3. Konten Utama
          Positioned.fill(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_welcome.png',
                      width: 250,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "BINTANG\nHARIAN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Kebiasaan baik hari ini,\nmasa depan hebat nanti ✨",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color:
                            const Color.fromARGB(246, 255, 255, 255), // <--- Koma ini yang tadi hilang!
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    Container(
                      width: 150,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: AnimatedFractionallySizedBox(
                        duration: const Duration(seconds: 2),
                        widthFactor: _widthFactor,
                        alignment: Alignment.centerLeft,
                        child: Container(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 40),
                    if (_showButton)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.indigo,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "MULAI",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Bintang Berkedip (Dipisah di luar kelas _WelcomePageState)
class TwinklingStar extends StatefulWidget {
  const TwinklingStar({super.key});
  @override
  State<TwinklingStar> createState() => _TwinklingStarState();
}

class _TwinklingStarState extends State<TwinklingStar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double _top = Random().nextDouble() * 800;
  final double _left = Random().nextDouble() * 400;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000 + Random().nextInt(2000)),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _top,
      left: _left,
      child: FadeTransition(
        opacity: _controller,
        child: const Icon(Icons.star, size: 8, color: Colors.white54),
      ),
    );
  }
}
