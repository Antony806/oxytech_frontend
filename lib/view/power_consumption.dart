import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oxy_tech/utils/constants.dart';

class PowerConsumption extends StatefulWidget {
  const PowerConsumption({super.key});

  @override
  State<PowerConsumption> createState() => _PowerConsumptionState();
}

class _PowerConsumptionState extends State<PowerConsumption> {
  final Random _random = Random();
  List<FlSpot> _spots = [];
  double _minPower = double.infinity;
  double _maxPower = double.negativeInfinity;
  double _averagePower = 0.0;
  List<double> _powerValues = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _generateInitialData();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _updatePowerConsumption();
    });
  }

  void _generateInitialData() {
    for (int i = 0; i < 7; i++) {
      double power = 228 + _random.nextDouble() * 2;
      _powerValues.add(power);
      _updateStatistics(power);
      _spots.add(FlSpot(i.toDouble(), power));
    }
  }

  void _updatePowerConsumption() {
    if (mounted) {
      setState(() {
        double newPower = 228 + _random.nextDouble() * 2;

        if (_spots.length >= 7) {
          double removedPower = _spots.first.y;
          _spots.removeAt(0);
          _powerValues.removeAt(0);
          _updateStatistics(removedPower, isAddition: false);
        }

        _powerValues.add(newPower);
        _spots.add(FlSpot(_spots.length.toDouble(), newPower));
        _updateStatistics(newPower);
      });
    }
  }

  void _updateStatistics(double power, {bool isAddition = true}) {
    if (isAddition) {
      _powerValues.add(power);
    } else {
      _powerValues.remove(power);
    }

    if (_powerValues.isNotEmpty) {
      _minPower = _powerValues.reduce((a, b) => a < b ? a : b);
      _maxPower = _powerValues.reduce((a, b) => a > b ? a : b);
      _averagePower =
          _powerValues.reduce((a, b) => a + b) / _powerValues.length;
    } else {
      _minPower = double.infinity;
      _maxPower = double.negativeInfinity;
      _averagePower = 0.0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Power Consumption',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFA9C7C3),
              Color.fromRGBO(125, 168, 160, 0.7),
              Color(0xFFEDEDED),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.47, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                height: sizeh(context) * 0.12,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_powerValues.isEmpty ? '0' : _powerValues.last.toStringAsFixed(1)}',
                      style: TextStyle(
                          color: Colors.black, fontSize: sizew(context) * 0.04),
                    ),
                    Text(
                      'Volts',
                      style: TextStyle(
                          color: Colors.black, fontSize: sizew(context) * 0.04),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizeh(context) * 0.05,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                height: sizeh(context) * 0.3,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const style = TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            );
                            return Text(value.toInt().toString(), style: style);
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const style = TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            );
                            return Text(value.toInt().toString(), style: style);
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                        show: true, border: Border.all(color: Colors.black)),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _spots,
                        isCurved: true,
                        color: const Color(0xff609c90),
                        dotData: const FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: sizeh(context) * 0.1,
              ),
              Container(
                width: double.infinity,
                height: sizeh(context) * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${_minPower.toStringAsFixed(1)}'),
                        const Text('Min'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_averagePower.toStringAsFixed(1)}',
                        ),
                        const Text(
                          'Avg',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_maxPower.toStringAsFixed(1)}',
                        ),
                        Text(
                          'Max',
                          style: TextStyle(color: Colors.red[700]),
                        ),
                      ],
                    ),
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
