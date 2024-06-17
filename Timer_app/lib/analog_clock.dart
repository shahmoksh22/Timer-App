import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class AnalogClock extends StatefulWidget {
  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/wall_background.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Container(
                width: double.infinity/2,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                ),// Set the clock background color to white
              ),
            ),
            Center(
              child: CustomPaint(
                size: Size(300, 300),
                painter: AnalogClockPainter(_currentTime),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnalogClockPainter extends CustomPainter {
  final DateTime dateTime;

  AnalogClockPainter(this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = min(centerX, centerY);

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    // Draw outer circle
    paint.strokeWidth = 8;
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Draw inner circle for aesthetics
    paint.strokeWidth = 4;
    canvas.drawCircle(Offset(centerX, centerY), radius - 10, paint);

    // Draw hour hand
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final minuteHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final secondHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Calculate the angles
    final hourAngle =
        ((dateTime.hour % 12) + dateTime.minute / 60) * 30 * pi / 180;
    final minuteAngle = (dateTime.minute + dateTime.second / 60) * 6 * pi / 180;
    final secondAngle = dateTime.second * 6 * pi / 180;

    // Draw the hands
    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(centerX + radius * 0.5 * cos(hourAngle - pi / 2),
          centerY + radius * 0.5 * sin(hourAngle - pi / 2)),
      hourHandPaint,
    );

    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(centerX + radius * 0.7 * cos(minuteAngle - pi / 2),
          centerY + radius * 0.7 * sin(minuteAngle - pi / 2)),
      minuteHandPaint,
    );

    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(centerX + radius * 0.9 * cos(secondAngle - pi / 2),
          centerY + radius * 0.9 * sin(secondAngle - pi / 2)),
      secondHandPaint,
    );

    // Draw center circle
    paint.color = Colors.black;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), 8, paint);

    // Draw numbers
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 1; i <= 12; i++) {
      textPainter.text = TextSpan(
        text: '$i',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
      );

      textPainter.layout();
      final x = centerX + radius * 0.8 * cos((i * 30 - 90) * pi / 180) -
          textPainter.width / 2;
      final y = centerY + radius * 0.8 * sin((i * 30 - 90) * pi / 180) -
          textPainter.height / 2;
      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}




class StrapWatch extends StatefulWidget {
  @override
  _StrapWatchState createState() => _StrapWatchState();
}

class _StrapWatchState extends State<StrapWatch> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey[800]!, width: 4.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: Text(
          '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}',
          style: TextStyle(
            fontSize: 48.0,
            color: Colors.green,
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DigitalWatch extends StatefulWidget {
  @override
  _DigitalWatchState createState() => _DigitalWatchState();
}

class _DigitalWatchState extends State<DigitalWatch> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/wall_background.webp'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.grey[800]!, width: 4.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          child: Text(
            '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 48.0,
              color: Colors.green,
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
