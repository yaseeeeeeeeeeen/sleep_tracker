import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../../core/consts/app_constants.dart';
import '../../../../../core/consts/color_manager.dart';

class CircularDial extends StatefulWidget {
  final Duration currentDuration;
  final ValueChanged<Duration> onDurationChanged;
  final double size;

  const CircularDial({
    Key? key,
    required this.currentDuration,
    required this.onDurationChanged,
    this.size = 288,
  }) : super(key: key);

  @override
  State<CircularDial> createState() => _CircularDialState();
}

class _CircularDialState extends State<CircularDial> {
  double _angle = 0;

  @override
  void initState() {
    super.initState();
    _angle = _durationToAngle(widget.currentDuration);
  }

  @override
  void didUpdateWidget(CircularDial oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentDuration != oldWidget.currentDuration) {
      _angle = _durationToAngle(widget.currentDuration);
    }
  }

  double _durationToAngle(Duration duration) {
    // Map duration (0-12 hours) to angle (0-360 degrees)
    final minutes = duration.inMinutes;
    final maxMinutes = SleepConstants.maxSleepMinutes; // 12 hours = 720 minutes
    return (minutes / maxMinutes) * 360;
  }

  Duration _angleToDuration(double angle) {
    // Map angle (0-360) to duration (0-12 hours)
    final maxMinutes = SleepConstants.maxSleepMinutes;
    final minutes = ((angle / 360) * maxMinutes).round();
    // Round to nearest 15 minutes for better UX
    final roundedMinutes = (minutes / 15).round() * 15;
    return Duration(
        minutes:
            roundedMinutes.clamp(SleepConstants.minSleepMinutes, maxMinutes));
  }

  void _handlePanUpdate(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;

    // Calculate angle from center
    double angle = math.atan2(dy, dx) * 180 / math.pi;
    // Adjust to start from top (0 degrees at top)
    angle = (angle + 90) % 360;
    if (angle < 0) angle += 360;

    setState(() {
      _angle = angle;
    });

    widget.onDurationChanged(_angleToDuration(_angle));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        _handlePanUpdate(details.localPosition, box.size);
      },
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: CustomPaint(
          painter: _DialPainter(
            angle: _angle,
            duration: widget.currentDuration,
          ),
        ),
      ),
    );
  }
}

class _DialPainter extends CustomPainter {
  final double angle;
  final Duration duration;

  _DialPainter({required this.angle, required this.duration});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw background track
    final trackPaint = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24;

    canvas.drawCircle(center, radius - 12, trackPaint);

    // Draw dashed inner circle
    final dashedPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final dashedPath = Path();
    const dashCount = 60;
    for (int i = 0; i < dashCount; i++) {
      final angle = (i / dashCount) * 2 * math.pi;
      final x1 = center.dx + (radius - 40) * math.cos(angle);
      final y1 = center.dy + (radius - 40) * math.sin(angle);
      final x2 = center.dx + (radius - 35) * math.cos(angle);
      final y2 = center.dy + (radius - 35) * math.sin(angle);
      dashedPath.moveTo(x1, y1);
      dashedPath.lineTo(x2, y2);
    }
    canvas.drawPath(dashedPath, dashedPaint);

    // Draw active arc
    final arcPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;

    final sweepAngle = angle * math.pi / 180;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 12),
      -math.pi / 2, // Start from top
      sweepAngle,
      false,
      arcPaint,
    );

    // Draw knob
    final knobAngle = angle * math.pi / 180 - math.pi / 2;
    final knobX = center.dx + (radius - 12) * math.cos(knobAngle);
    final knobY = center.dy + (radius - 12) * math.sin(knobAngle);

    // Knob outer circle
    final knobOuterPaint = Paint()
      ..color = AppColors.backgroundDark
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(knobX, knobY), 18, knobOuterPaint);

    // Knob border
    final knobBorderPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(Offset(knobX, knobY), 18, knobBorderPaint);

    // Knob inner dot
    final knobDotPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(knobX, knobY), 5, knobDotPaint);

    // Draw labels
    _drawLabels(canvas, center, radius);
  }

  void _drawLabels(Canvas canvas, Offset center, double radius) {
    final textStyle = TextStyle(
      color: Colors.grey.shade600,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    final labels = ['12h', '3h', '6h', '9h'];
    final angles = [0, 90, 180, 270];

    for (int i = 0; i < labels.length; i++) {
      final textSpan = TextSpan(text: labels[i], style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final angle = angles[i] * math.pi / 180 - math.pi / 2;
      final x =
          center.dx + (radius + 20) * math.cos(angle) - textPainter.width / 2;
      final y =
          center.dy + (radius + 20) * math.sin(angle) - textPainter.height / 2;

      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(_DialPainter oldDelegate) {
    return oldDelegate.angle != angle || oldDelegate.duration != duration;
  }
}
