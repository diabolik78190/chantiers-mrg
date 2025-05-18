import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  String role = '';

  @override
  void initState() {
    super.initState();
    fetchUserRole();
  }

  Future<void> fetchUserRole() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      setState(() {
        role = doc.data()!['role'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu VibeConnect', style: TextStyle(color: Colors.white)),
          ),
          if (role == 'admin') ...[
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pushNamed(context, '/demo');
              },
            ),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Valider salariés'),
              onTap: () {
                Navigator.pushNamed(context, '/validation');
              },
            ),
          ],
          if (role == 'salarie') ...[
            ListTile(
              leading: const Icon(Icons.home_repair_service),
              title: const Text('Chantiers'),
              onTap: () {
                // Exemple : Navigator.pushNamed(context, '/chantiers');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Matériel à demander'),
              onTap: () {
                // Exemple : Navigator.pushNamed(context, '/materiel');
              },
            ),
          ],
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
