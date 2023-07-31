import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DiceRollScreen(),
    );
  }
}

class DiceRollScreen extends StatefulWidget {
  const DiceRollScreen({super.key});

  @override
  _DiceRollScreenState createState() => _DiceRollScreenState();
}

class _DiceRollScreenState extends State<DiceRollScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int _currentDiceValue = 1;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  void _rollDice() {
    setState(() {
      _currentDiceValue = _random.nextInt(6) + 1;
    });
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff01FE83),
      appBar: AppBar(
        title: const Text('Animated Dice Roll'),
      ),
      body: Center(
        child: Container(
          color: const Color.fromARGB(0, 255, 128, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value * pi,
                    child: child,
                  );
                },
                child: GestureDetector(
                  onTap: _rollDice,
                  child: Image.asset(
                    'assets/images/dice-$_currentDiceValue.png',
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    WavyAnimatedText('Tap on the dice to roll!'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
