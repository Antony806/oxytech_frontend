import 'package:flutter/material.dart';

class Privacypolicy extends StatelessWidget {
  const Privacypolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Privacy Policy',
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
                'Last updated: August 01, 2024\nThis Privacy Policy outlines how we collect, use, and disclose your information when you use our Service, and your privacy rights.\nDefinitions:\nAccount: Unique account for accessing our Service.\nCompany: OxyTech (referred to as "We," "Us," or "Our").\nDevice: Any device accessing the Service (e.g., computer, mobile).\nPersonal Data: Information that identifies you.\nService: The OxyTech Application.\nUsage Data: Automatically collected data during your use of the Service.\nData Collection: We may collect Personal Data including your email, name, phone number, and address, as well as Usage Data such as your IP address and device information. With your permission, we may also collect location data and media from your device.\nUse of Personal Data: We use your data for:\nProviding and maintaining our Service.\nManaging your Account.\nContacting you with updates and promotional information.\nData Sharing: We may share your information with:\nAffiliates and business partners for products and services.\nOther users when you interact publicly.\nLaw enforcement, if required by law.\nData Retention: We retain your Personal Data only as necessary to fulfill the purposes outlined in this policy or to comply with legal obligations.\nData Transfer: Your information may be processed in locations outside your jurisdiction. We will ensure adequate data protection measures are in place.\nRights to Your Data: You can request deletion or update of your Personal Data at any time through your account settings or by contacting us.\nChildren’s Privacy: Our Service is not intended for those under 13. We do not knowingly collect data from children without parental consent.\nChanges to This Policy: We may update this Privacy Policy and will notify you of significant changes via email or notice on our Service.\nContact Us: For questions, contact us at: oxytech@gmail.co'),
          ),
        ),
      ),
    );
  }
}
