import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oxy_tech/view/control_system.dart';
import 'package:oxy_tech/view/emergency.dart';
import 'package:oxy_tech/view/health_conditions.dart';
import 'package:oxy_tech/view/notification_screen.dart';
import 'package:oxy_tech/view/oxygen_production.dart';

import 'package:oxy_tech/view/patient_history.dart';
import 'package:oxy_tech/view/power_consumption.dart';
import 'package:oxy_tech/view/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          return snapshot.get('name');
        } else {
          return 'Unknown User';
        }
      } catch (e) {
        return 'Unknown User';
      }
    } else {
      return 'Unknown User';
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showConnectingDialog();
    });
  }

  void _navigateToPage(int index) {
    final List<Widget> pages = [
      const HealthConditions(),
      const PatientHistory(),
      const OxygenProduction(),
      const PowerConsumption(),
      const Emergency(),
      const ControlSystem(),
    ];

    if (index >= 0 && index < pages.length) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pages[index]),
      );
    }
  }

  void _showConnectingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Connecting'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Connecting to the Raspberry Pi'),
              SizedBox(height: 20),
              CircularProgressIndicator(
                color: Colors.teal,
              ),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context, rootNavigator: true).pop();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Connected'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 50),
                SizedBox(height: 20),
                Text('Connected successfully'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFA9C7C3),
              Color(0xFF5F998E),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              height: MediaQuery.of(context).size.width * 0.4,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(34),
                  bottomRight: Radius.circular(34),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            'https://th.bing.com/th/id/OIP.PoS7waY4-VeqgNuBSxVUogAAAA?rs=1&pid=ImgDetMain',
                          ),
                        ),
                        const SizedBox(width: 20),
                        FutureBuilder<String>(
                          future: _fetchUserName(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                'Loading...',
                                style: TextStyle(color: Colors.black),
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(color: Colors.black),
                              );
                            } else {
                              return Text(
                                snapshot.data ?? 'Unknown User',
                                style: const TextStyle(color: Colors.black),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.settings, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },
              child: Container(
                width: 350,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.teal[50],
                ),
                child: const Row(
                  children: [
                    Text(
                      "  Notification",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.notifications,
                      color: Colors.black,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => _navigateToPage(index),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            image: AssetImage('assets/Grid${index + 1}.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy page classes (Replace these with actual implementations)








