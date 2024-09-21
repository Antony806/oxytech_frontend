import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HealthConditions extends StatefulWidget {
  const HealthConditions({Key? key}) : super(key: key);

  @override
  _HealthConditionsState createState() => _HealthConditionsState();
}

class _HealthConditionsState extends State<HealthConditions> {
  // Firebase database reference
  final DatabaseReference _databaseReference = FirebaseDatabase.instance
      .ref()
      .child('sensor_data/2024-08-26/time_data');

  
  Map<String, dynamic>? sensorData;
  List<String> timeKeys = []; 
  String? currentDisplayedTimeKey; 
  String selectedDataType = 'heart_rate'; 

  
  Timer? _timer;
  int currentIndex = 0; 

  @override
  void initState() {
    super.initState();
    
    getData();
  }

  @override
  void dispose() {
    
    stopPeriodicUpdate();
    super.dispose();
  }

  
  void startPeriodicUpdate() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && timeKeys.isNotEmpty) {
        setState(() {
          currentDisplayedTimeKey = timeKeys[currentIndex];
          currentIndex = (currentIndex + 1) % timeKeys.length; 
        });
      }
    });
  }

  
  void stopPeriodicUpdate() {
    _timer?.cancel();
  }

  // Retrieve data from Firebase Realtime Database
  Future<void> getData() async {
    DatabaseEvent event = await _databaseReference.once();
    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {
      setState(() {
        sensorData = Map<String, dynamic>.from(snapshot.value as Map);
        timeKeys = sensorData!.keys.toList();
        if (timeKeys.isNotEmpty) {
          currentDisplayedTimeKey = timeKeys[currentIndex]; 
          startPeriodicUpdate(); // Start periodic updates to rotate through data
        }
      });
    } else {
      print("No data found at the specified path.");
    }
  }

  
  void switchDataType(String dataType) {
    setState(() {
      selectedDataType = dataType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Conditions')),
      body: sensorData != null && currentDisplayedTimeKey != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const SizedBox(height: 10),
                  // Row for buttons to switch between Heart Rate and SpO2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => switchDataType('heart_rate'),
                        child: const Text('Heart Rate'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedDataType == 'heart_rate'
                              ? const Color.fromARGB(255, 82, 185, 95)
                              : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => switchDataType('spo2'),
                        child: const Text('SpO2'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedDataType == 'spo2' ? const Color.fromARGB(255, 74, 190, 76) : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Display the relevant data for the selected type
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
                            // Display the selected data type (Heart Rate or SpO2)
                            Text(
                              selectedDataType == 'heart_rate'
                                  ? 'Heart Rate: ${sensorData![currentDisplayedTimeKey]['heart_rate']}'
                                  : 'SpO2: ${sensorData![currentDisplayedTimeKey]['spo2']}',
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