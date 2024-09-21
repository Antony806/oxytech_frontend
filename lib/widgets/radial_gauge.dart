import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGaugeWidget extends StatefulWidget {
  final double initialValue;
  final double minValue;
  final double maxValue;

  const RadialGaugeWidget({
    Key? key,
    this.initialValue = 2.5, // Start at 2.5
    this.minValue = 0.0, // Minimum value
    this.maxValue = 6.0, // Maximum value
  }) : super(key: key);

  @override
  _RadialGaugeWidgetState createState() => _RadialGaugeWidgetState();
}

class _RadialGaugeWidgetState extends State<RadialGaugeWidget> {
  late double _gaugeValue;

  @override
  void initState() {
    super.initState();
    _gaugeValue =
        widget.initialValue; // Initialize to the provided initial value
  }

  // Function to increment the value by 0.1
  void _incrementValue() {
    setState(() {
      if (_gaugeValue < widget.maxValue) {
        _gaugeValue += 0.1;
        _gaugeValue =
            double.parse(_gaugeValue.toStringAsFixed(1)); // Fix to one decimal
      }
    });
  }

  // Function to decrement the value by 0.1
  void _decrementValue() {
    setState(() {
      if (_gaugeValue > widget.minValue) {
        _gaugeValue -= 0.1;
        _gaugeValue =
            double.parse(_gaugeValue.toStringAsFixed(1)); // Fix to one decimal
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: widget.minValue,
                  maximum: widget.maxValue,
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: widget.minValue,
                      endValue: _gaugeValue,
                      color: Colors.blueAccent,
                      startWidth: 10,
                      endWidth: 10,
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value:
                          _gaugeValue, // Ensure the needle points to the current value
                      enableAnimation: true, // Enable smooth animation
                      needleLength:
                          0.7, // Adjust length of needle for better visibility
                      needleColor: Colors.red, // Customize needle color
                      knobStyle: KnobStyle(
                        color: Colors.black,
                        borderColor: Colors.red,
                        borderWidth: 0.02,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        _gaugeValue.toStringAsFixed(1),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      angle: 90,
                      positionFactor: 0.5,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementValue,
                  child: Text('-'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _incrementValue,
                  child: Text('+'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
