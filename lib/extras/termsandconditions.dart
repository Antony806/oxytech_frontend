import 'package:flutter/material.dart';

class Termsandconditions extends StatelessWidget {
  const Termsandconditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Terms and Conditions',
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
            child: Text(
                "Last Updated: August 01, 2024\nThese Terms govern your use of the OxyTech Medical Application (\"Service\"). By using the Service, you agree to these Terms. If you do not agree, please do not use the Service.\n1. Acceptance of Terms By accessing or using the Service, you confirm you are at least 18 years old or have parental consent. If using on behalf of an organization, you must have the authority to bind that organization.\n2. Service Description The Service allows patients to monitor and manage oxygen supply from connected concentrators, providing features like real-time monitoring and alerts.\n3. User Responsibilities You must provide accurate information, maintain the confidentiality of your account, and comply with all applicable laws.\n4. Medical Disclaimer The Service is not a substitute for professional medical advice. Always consult a healthcare provider regarding any medical questions.\n5. Use of the Service You are granted a limited license to use the Service for personal purposes. Modifying or distributing content without permission is prohibited.\n6. Data Collection and Privacy Your use of the Service is governed by our Privacy Policy, which outlines how we collect and use your information.\n7. Limitation of Liability OxyTech is not liable for any indirect or consequential damages. Your sole remedy for dissatisfaction with the Service is to discontinue use.\n8. Indemnification You agree to indemnify OxyTech against any claims arising from your use of the Service or violation of these Terms.\n9. Modifications We may modify these Terms at any time. Continued use of the Service after changes indicates acceptance of the new Terms.\n10. Termination We may suspend or terminate your access to the Service at our discretion, without notice.\n11. Governing Law These Terms are governed by the laws of Tamil Nadu, India. Disputes will be subject to the jurisdiction of Tamil Nadu courts.\n12. Contact Us For questions, contact us at:\nEmail: oxytech@gmail.com"),
          ),
        ),
      ),
    );
  }
}
