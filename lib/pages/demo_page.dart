import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Page Démo - contenu existant',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
