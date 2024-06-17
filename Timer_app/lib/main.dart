
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:timer_app/analog_clock.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    TimerScreen(),
    AnalogClock(),
    DigitalWatch(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Timer App')),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch),
            label: 'Strap Watch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Digital Watch',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int _start = 0;
  bool _isRunning = false;
  List<String> _laps = [];

  void startTimer() {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _timer?.cancel();
          _isRunning = false;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void stopTimer() {
    if (!_isRunning) return;
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      _start = 0;
      _laps.clear();
    });
  }

  void addLap() {
    if (_isRunning) {
      setState(() {
        _laps.add('Lap ${_laps.length + 1}: ${_start}s');
      });
    }
  }

  void setTimer(int seconds) {
    setState(() {
      _start = seconds;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "$_start",
          style: TextStyle(fontSize: 48.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => setTimer(60),
              child: Text("Set 1 Min"),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: startTimer,
              child: Text("Start"),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: stopTimer,
              child: Text("Stop"),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: resetTimer,
              child: Text("Reset"),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: addLap,
          child: Text("Add Lap"),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _laps.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_laps[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
