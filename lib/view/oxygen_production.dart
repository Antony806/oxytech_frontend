import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OxygenProduction extends StatefulWidget {
  const OxygenProduction({Key? key}) : super(key: key);

  @override
  State<OxygenProduction> createState() => _OxygenProductionState();
}

class _OxygenProductionState extends State<OxygenProduction> {
  final Random _random = Random();
  List<BarChartGroupData> _barGroups = [];
  double _minFlowRate = double.infinity;
  double _maxFlowRate = double.negativeInfinity;
  double _averageFlowRate = 0.0;
  List<double> _flowRateValues = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _generateInitialData();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _updateFlowRate();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _generateInitialData() {
    for (int i = 0; i < 7; i++) {
      double flowRate = 1.7 + _random.nextDouble() * 0.3;
      _flowRateValues.add(flowRate);
      _updateStatistics(flowRate);
      _barGroups.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: flowRate * 10,
            color: const Color(0xff609c90),
            width: 30,
            borderRadius: BorderRadius.zero,
          ),
        ],
      ));
    }
  }

  void _updateFlowRate() {
    if (!mounted) return;
    setState(() {
      double newFlowRate = 1.7 + _random.nextDouble() * 0.3;

      if (_barGroups.length >= 7) {
        double removedFlowRate = _barGroups.first.barRods.first.toY / 10;
        _barGroups.removeAt(0);
        _flowRateValues.removeAt(0);
        _updateStatistics(removedFlowRate, isAddition: false);
      }

      _flowRateValues.add(newFlowRate);
      _barGroups.add(BarChartGroupData(
        x: _barGroups.length,
        barRods: [
          BarChartRodData(
            toY: newFlowRate * 10,
            color: const Color(0xff609c90),
            width: 20,
            borderRadius: BorderRadius.zero,
          ),
        ],
      ));
      _updateStatistics(newFlowRate);
    });
  }

  void _updateStatistics(double flowRate, {bool isAddition = true}) {
    if (isAddition) {
      _flowRateValues.add(flowRate);
    } else {
      _flowRateValues.remove(flowRate);
    }

    if (_flowRateValues.isNotEmpty) {
      _minFlowRate = _flowRateValues.reduce((a, b) => a < b ? a : b);
      _maxFlowRate = _flowRateValues.reduce((a, b) => a > b ? a : b);
      _averageFlowRate = _flowRateValues.reduce((a, b) => a + b) / _flowRateValues.length;
    } else {
      _minFlowRate = double.infinity;
      _maxFlowRate = double.negativeInfinity;
      _averageFlowRate = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Oxygen Production',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF689D93),
                          Color(0xFF35786A),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Flow rate',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          '${_flowRateValues.isEmpty ? '0.0' : _flowRateValues.last.toStringAsFixed(1)} ltr/hr',
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF689D93),
                          Color(0xFF35786A),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Purity',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        
                        Text(
                          '99 %',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                height: 250,
                child: BarChart(
                  BarChartData(
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
                            return Text((value / 10).toStringAsFixed(1), style: style);
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
                    borderData: FlBorderData(show: true, border: Border.all(color: Colors.black)),
                    barGroups: _barGroups,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 80,
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
                        Text('${_minFlowRate.toStringAsFixed(1)}'),
                        const Text('Min'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${_averageFlowRate.toStringAsFixed(1)}'),
                        const Text('Avg', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${_maxFlowRate.toStringAsFixed(1)}'),
                        const Text('Max', style: TextStyle(color: Colors.red)),
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
