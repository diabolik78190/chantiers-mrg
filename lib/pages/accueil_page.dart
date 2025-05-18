import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'nouveau_chantier_page.dart';
import 'nouveau_salarie_page.dart';
import 'liste_chantiers_en_cours_page.dart';
import 'chantiers_termines_page.dart';
import 'liste_salaries_page.dart';
import 'chat_page.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  void _deconnexion(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/connexion', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chantiers-MRG - Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _deconnexion(context),
            tooltip: 'Déconnexion',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildMenuItem(
              context,
              icon: Icons.construction,
              label: 'Nouveau Chantier',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const NouveauChantierPage()));
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.engineering,
              label: 'Nouveau Salarié',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const NouveauSalariePage()));
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.list_alt,
              label: 'Chantiers en cours',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ListeChantiersEnCoursPage()));
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.check_circle,
              label: 'Chantiers terminés',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ChantiersTerminesPage()));
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.people,
              label: 'Liste des salariés',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ListeSalariesPage()));
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.chat,
              label: 'Chat d\'équipe',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) =>  ChatPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.green.shade700),
            const SizedBox(height: 12),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
