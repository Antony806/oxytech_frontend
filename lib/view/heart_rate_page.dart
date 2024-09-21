import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HeartRate extends StatefulWidget {
  const HeartRate({Key? key}) : super(key: key);

  @override
  State<HeartRate> createState() => _HeartRateState();
}

class _HeartRateState extends State<HeartRate> {
  final DatabaseReference _heartRateRef =
      FirebaseDatabase.instance.ref('heart_rate'); // Update your path
  final List<FlSpot> _spots = [];
  double _lastX = 0.0;

  double _minBPM = double.infinity;
  double _maxBPM = double.negativeInfinity;
  double _averageBPM = 0.0;
  int _totalReadings = 0;
  int _sumBPM = 0;

  StreamSubscription<DatabaseEvent>? _heartRateSubscription;

  @override
  void initState() {
    super.initState();
    _heartRateSubscription = _heartRateRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?; // Adjust based on your data structure
      if (data != null) {
        _updateHeartRate(data);
      }
    });
  }

  void _updateHeartRate(Map<dynamic, dynamic> data) {
    double bpm = data['bpm'].toDouble(); // Adjust key according to your data structure
    setState(() {
      if (_spots.length >= 10) {
        double removedBPM = _spots.first.y;
        _spots.removeAt(0);
        _updateStatistics(removedBPM, isAddition: false);
      }
      _spots.add(FlSpot(_lastX += 0.5, bpm));
      _updateStatistics(bpm);
    });
  }

  void _updateStatistics(double bpm, {bool isAddition = true}) {
    if (isAddition) {
      _totalReadings++;
      _sumBPM += bpm.toInt();
      if (bpm < _minBPM) _minBPM = bpm;
      if (bpm > _maxBPM) _maxBPM = bpm;
    } else {
      _totalReadings--;
      _sumBPM -= bpm.toInt();
      if (_spots.isEmpty) {
        _minBPM = double.infinity;
        _maxBPM = double.negativeInfinity;
      }
    }
    _averageBPM = _totalReadings > 0 ? _sumBPM / _totalReadings : 0.0;
  }

  @override
  void dispose() {
    _heartRateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Rate'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0C9C9), Color.fromRGBO(160, 140, 140, 0.7), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Heart Rate: ${_spots.isNotEmpty ? _spots.last.y.toStringAsFixed(1) : 'Loading...'} BPM', style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              Container(
                height: 200,
                child: LineChart(LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _spots,
                      isCurved: true,
                      color: Colors.red,
                    ),
                  ],
                )),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Text(_minBPM.toStringAsFixed(1)),
                    const Text('Min'),
                  ]),
                  Column(children: [
                    Text(_averageBPM.toStringAsFixed(1)),
                    const Text('Avg', style: TextStyle(color: Colors.green)),
                  ]),
                  Column(children: [
                    Text(_maxBPM.toStringAsFixed(1)),
                    const Text('Max', style: TextStyle(color: Colors.red)),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
