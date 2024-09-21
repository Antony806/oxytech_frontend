import 'package:flutter/material.dart';
import 'package:oxy_tech/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Emergency',
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
              const Text(
                'Emergency Calling',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: sizeh(context) * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Image.asset('assets/sos.png'),
              ),
              SizedBox(
                height: sizeh(context) * 0.3,
              ),
              GestureDetector(
                onHorizontalDragEnd: (details) {
                  _makeEmergencyCall();
                },
                child: Container(
                  width: double.infinity,
                  height: sizeh(context) * 0.09,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0438, 1.1228],
                      colors: [
                        Color(0xFF67BFAE),
                        Color(0xFF265850),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Text(
                      'Swipe to SOS',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }

 

void _makeEmergencyCall() async {
  const url = 'tel:108';
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not launch the dialer.')),
    );
  }
}

}