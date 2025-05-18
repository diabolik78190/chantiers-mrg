import 'package:flutter/material.dart';

class ChantiersTerminesPage extends StatelessWidget {
  const ChantiersTerminesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chantiers terminés')),
      body: const Center(
        child: Text(
          'Liste des chantiers terminés',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
