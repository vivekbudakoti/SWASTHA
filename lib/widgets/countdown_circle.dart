import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swastha/utils/styles.dart';

class CountdownCircle extends StatefulWidget {
  const CountdownCircle({Key? key, required this.duration}) : super(key: key);
  final Duration duration;
  @override
  State<CountdownCircle> createState() => _CountdownCircleState();
}

class _CountdownCircleState extends State<CountdownCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.forward().orCancel;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CustomPaint(
          painter: _CircleCountdownPainter(
              thinRing: kPrimaryColor,
              tickerRing: kPrimaryColor,
              animation: Tween<double>(begin: 0.0, end: pi * 2).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.linear))),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _CircleCountdownPainter extends CustomPainter {
  _CircleCountdownPainter(
      {required this.animation,
      required this.thinRing,
      required this.tickerRing})
      : fillerPaint = Paint()
          ..color = kPrimaryColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 42.0
          ..strokeCap = StrokeCap.round,
        super(repaint: animation);

  // The color of the thinRing
  final Color thinRing;

  // The color of the ticking circle
  final Color tickerRing;
  final Animation<double> animation;
  final Paint fillerPaint;

  Paint circlePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide * 0.30);
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Draw the thin ring
    canvas.drawCircle(
      center,
      radius,
      circlePaint..color = thinRing,
    );

    final Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[kPrimaryColor, tickerRing, Colors.blue],
      stops: const [0.0, 0.5, 1.0],
    );

    /// Draw the countdown circle based on [animation.value]
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(pi * 3 / 2);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawArc(
      rect,
      0,
      animation.value,
      false,
      fillerPaint..shader = gradient.createShader(rect),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CircleCountdownPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
