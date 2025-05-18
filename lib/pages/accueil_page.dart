import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'nouveau_chantier_page.dart';
import 'nouveau_salarie_page.dart';
import 'liste_chantiers_en_cours_page.dart';
import 'chantiers_termines_page.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  void _deconnexion(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/connexion');
  }

  @override
  Widget build(BuildContext context) {
    // Style commun pour les boutons
    final ButtonStyle boutonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 60),
      textStyle: const TextStyle(fontSize: 18),
      padding: const EdgeInsets.symmetric(horizontal: 20),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () => _deconnexion(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              style: boutonStyle,
              icon: Image.asset('assets/images/chantier.png', width: 32, height: 32),
              label: const Text('Nouveau Chantier'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NouveauChantierPage()),
                );
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: boutonStyle,
              icon: Image.asset('assets/images/salarie.png', width: 32, height: 32),
              label: const Text('Nouveau Salarié'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NouveauSalariePage()),
                );
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: boutonStyle,
              icon: Image.asset('assets/images/chantier_en_cours.png', width: 32, height: 32),
              label: const Text('Liste des Chantiers en Cours'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListeChantiersEnCoursPage()),
                );
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: boutonStyle,
              icon: Image.asset('assets/images/chantier_termine.png', width: 32, height: 32),
              label: const Text('Chantiers Terminés'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChantiersTerminesPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
