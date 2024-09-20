import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference _databaseReference = 
        FirebaseDatabase.instance.ref().child('sensor_data/2024-08-26/time_data/10:26:11');

  Map<String, dynamic>? sensorData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  // Retrieve data from Firebase Realtime Database
  Future<void> getData() async {
    DatabaseEvent event = await _databaseReference.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      setState(() {
        sensorData = Map<String, dynamic>.from(snapshot.value as Map);
      });
      // Print the retrieved data to the console
      print(sensorData);
    } else {
      print("No data found at the specified path.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Data'),
      ),
      body: sensorData == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: sensorData!.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key),
                  subtitle: Text(entry.value.toString()),
                );
              }).toList(),
            ),
    );
  }
}
