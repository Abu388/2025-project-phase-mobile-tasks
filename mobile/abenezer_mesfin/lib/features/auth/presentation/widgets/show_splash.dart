import 'dart:async';
import 'package:flutter/material.dart';

class ShowSplash extends StatefulWidget {
  final VoidCallback onSplashComplete;

  const ShowSplash({super.key, required this.onSplashComplete});

  @override
  State<ShowSplash> createState() => _ShowSplashState();
}

class _ShowSplashState extends State<ShowSplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    Timer(const Duration(seconds: 2), () {
      widget.onSplashComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with better alignment
          Image.asset(
            'assets/im.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          // Blue tint matching the UI
          Container(
            color: Colors.blue.withOpacity(0.4),
          ),
          // Animated foreground content
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'ECOM',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: 2,
                        shadows: [Shadow(color: Colors.black12, offset: Offset(1, 1), blurRadius: 2)],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'ECOMMERCE APP',
                    style: TextStyle(
                      fontFamily: 'Caveat Brush',
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




















// import 'dart:async';
// import 'package:flutter/material.dart';

// class ShowSplash extends StatefulWidget {
//   final VoidCallback onSplashComplete;

//   const ShowSplash({super.key, required this.onSplashComplete});

//   @override
//   State<ShowSplash> createState() => _ShowSplashState();
// }

// class _ShowSplashState extends State<ShowSplash> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 2), () {
//       widget.onSplashComplete();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // 🔹 Background image
//           Image.asset(
//             'assets/im.png', // <-- your background
//             fit: BoxFit.cover,
//           ),

//           // 🔹 Overlay with blue tint (optional like your UI)
//           Container(
//             color: Colors.blue.withOpacity(0.5),
//           ),

//           // 🔹 Foreground content
//           Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: const Text(
//                     'ECOM',
//                     style: TextStyle(
//                       fontSize: 40,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                       letterSpacing: 2,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'ECOMMERCE APP',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 const CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
                
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }















