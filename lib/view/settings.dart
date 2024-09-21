import 'package:flutter/material.dart';
import 'package:oxy_tech/extras/about.dart';
import 'package:oxy_tech/extras/privacypolicy.dart';
import 'package:oxy_tech/extras/termsandconditions.dart';

import 'package:oxy_tech/utils/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Settings',
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
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.dark_mode, color: Colors.black),
              title: const Text('Dark Mode'),
              trailing: Switch(
                activeColor: AppTheme.secondaryColor,
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
            ),
            const ListTile(
              leading: Icon(Icons.language, color: Colors.black),
              title: Text('Language'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
           
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutApp()),
                );
              },
              leading: const Icon(Icons.phone_android, color: Colors.black),
              title: const Text('About the app'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Termsandconditions()),
                );
              },
              leading: const Icon(Icons.sticky_note_2, color: Colors.black),
              title: const Text('Terms and Conditions'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Privacypolicy()),
                );
              },
              leading: const Icon(Icons.shield, color: Colors.black),
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const ListTile(
              leading: Icon(Icons.share, color: Colors.black),
              title: Text('Share this app'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
