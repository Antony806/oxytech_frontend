import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ControlSystem extends StatefulWidget {
  const ControlSystem({Key? key}) : super(key: key);

  @override
  _ControlSystemState createState() => _ControlSystemState();
}

class _ControlSystemState extends State<ControlSystem> {
  // Firebase database reference
  final DatabaseReference _databaseReference = FirebaseDatabase.instance
      .ref()
      .child('sensor_data/2024-08-26/time_data');

  // Map to hold control data
  Map<String, dynamic>? controlData;
  List<String> timeKeys = []; // List of time keys
  String? currentDisplayedTimeKey; // Current key being displayed
  Timer? _timer;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getData(); // Fetch data on initialization
  }

  @override
  void dispose() {
    stopPeriodicUpdate();
    super.dispose();
  }

  // Function to start periodic updates every second
  void startPeriodicUpdate() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && timeKeys.isNotEmpty) {
        setState(() {
          currentDisplayedTimeKey = timeKeys[currentIndex];
          currentIndex = (currentIndex + 1) % timeKeys.length; // Loop through the keys
        });
      }
    });
  }

  // Function to stop periodic updates
  void stopPeriodicUpdate() {
    _timer?.cancel();
  }

  // Retrieve data from Firebase Realtime Database
  Future<void> getData() async {
    DatabaseEvent event = await _databaseReference.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {
      setState(() {
        controlData = Map<String, dynamic>.from(snapshot.value as Map);
        timeKeys = controlData!.keys.toList(); // Get the time keys
        if (timeKeys.isNotEmpty) {
          currentDisplayedTimeKey = timeKeys[currentIndex]; // Display first entry
          startPeriodicUpdate(); // Start periodic updates
        }
      });
    } else {
      print("No data found at the specified path.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control System')),
      body: controlData != null && currentDisplayedTimeKey != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Control Data:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Display flow_rate, temperature, and humidity for the selected time
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time: $currentDisplayedTimeKey',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Flow Rate: ${controlData![currentDisplayedTimeKey!]['flow_rate']} L/min',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Temperature: ${controlData![currentDisplayedTimeKey!]['temperature']} °C',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Humidity: ${controlData![currentDisplayedTimeKey!]['humidity']} %',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}