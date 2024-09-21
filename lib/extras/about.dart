import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'About the App',
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
        child: const Padding(
          padding: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: const Text(
                'Welcome to OxyTech, your essential companion for managing oxygen therapy. Our innovative mobile application is designed to provide patients with seamless access to oxygen concentrators, allowing for real-time monitoring and regulation of oxygen supply.\nKey \nFeatures:Real-Time Monitoring: Track your oxygen levels and ensure you are receiving the optimal dosage at all times.\nRemote Management: Control and adjust your oxygen concentrator settings directly from your smartphone for convenience and ease of use.\nAlerts and Notifications: Receive timely alerts for low oxygen levels or when it’s time for maintenance, ensuring you never miss a crucial update.\nUser-Friendly Interface: Navigate through our intuitive design, making it easy to manage your oxygen therapy without hassle.\nSecure Data Management: Your health information is protected with robust security measures, ensuring your privacy and confidentiality.\nAt OxyTech, we prioritize your health and well-being. Our mission is to empower patients with the tools they need to manage their oxygen therapy effectively and improve their quality of life. Join our community today and take control of your oxygen therapy!For more information, please contact us at:\nEmail: oxytech@gmail.com'),
          ),
        ),
      ),
    );
  }
}
