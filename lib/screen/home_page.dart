import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<Offset> animationOffset;
  late Animation<double> animationWidth;
  late Animation<double> animationHeight;
  late Animation<double> animationBorderRadius;
  late Animation<Color?> animationColor;

  bool _showCircle = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(seconds: 3),
      lowerBound: 0,
      upperBound: 1,
    );

    animationWidth = Tween<double>(begin: 50, end: 250).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeInOut),
      ),
    );

    animationHeight = Tween<double>(begin: 50, end: 250).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.25, 0.55, curve: Curves.easeInOut),
      ),
    );

    animationOffset = Tween<Offset>(
      begin: const Offset(0.5, 0.5),
      end: const Offset(0, 3),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.25, 0.55, curve: Curves.easeInOut),
      ),
    );

    animationBorderRadius = Tween<double>(begin: 0, end: 250).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.55, 0.80, curve: Curves.easeInOut),
      ),
    );

    animationColor = ColorTween(
      begin: Colors.orangeAccent.withOpacity(0.8),
      end: Colors.redAccent.withOpacity(0.5),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.80, 1.0, curve: Curves.easeInOut),
      ),
    );

    animationController.addListener(() {
      setState(() {
        if (animationController.value > 0.8 &&
            animationController.status == AnimationStatus.forward) {
          _showCircle = true;
        } else {
          _showCircle = false;
        }
      });
    });

    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.2),
        elevation: 0,
        title: const Text(
          'Stagged Animation Demo',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: animationHeight.value,
              width: animationWidth.value,
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: animationOffset.value.dy * 100),
              decoration: BoxDecoration(
                color: _getAnimatedColor(
                    animationColor.value, animationController.value),
                border: Border.all(color: const Color(0xFF465BAB), width: 8),
                borderRadius:
                    BorderRadius.circular(animationBorderRadius.value),
              ),
              child: _showCircle
                  ? Center(
                      child: Container(
                        height: animationWidth.value - 16,
                        width: animationWidth.value - 16,
                        decoration: const BoxDecoration(
                          color: Colors.amberAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Color? _getAnimatedColor(Color? color, double controllerValue) {
    if (controllerValue > 0.9) {
      return Colors.amberAccent;
    } else {
      return color;
    }
  }
}
