import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      body: Stack(
        children: List.generate(
          100,
          (index) => RainDrop(
            width: width,
            height: height,
            xBeginning: Random().nextDouble() * width,
            dropSpeed: Duration(milliseconds: 500 + Random().nextInt(3000)),
          ),
        ),
      ),
    );
  }
}

class RainDrop extends StatefulWidget {
  RainDrop(
      {super.key,
      required this.width,
      required this.height,
      required this.xBeginning,
      required this.dropSpeed});

  double width;
  double height;

  double xBeginning;
  Duration dropSpeed;

  @override
  State<RainDrop> createState() => _RainDropState();
}

class _RainDropState extends State<RainDrop>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: widget.dropSpeed);

    animation = Tween<double>(begin: 0, end: widget.height)
        .animate(animationController);

    animationController.forward();

    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.reset();
        animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(widget.xBeginning, animation.value),
          child: Container(
            color: Colors.deepPurple,
            height: 20,
            width: 4,
          ),
        );
      },
    );
  }
}
