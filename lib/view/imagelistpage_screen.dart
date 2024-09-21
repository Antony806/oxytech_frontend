import 'package:flutter/material.dart';

class ImageListPage extends StatelessWidget {
  const ImageListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploaded PDFs'),
      ),
      body: Center(
        child: const Text('This is the page to display a list of PDFs.'),
      ),
    );
  }
}
