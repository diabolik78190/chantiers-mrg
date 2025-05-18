import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListeChantiersEnCoursPage extends StatelessWidget {
  const ListeChantiersEnCoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chantiers en cours'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chantiers')
            .where('termine', isEqualTo: false)
        // .orderBy('dateAjout', descending: true) // <-- Commenté pour test
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text('Aucun chantier en cours'));
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final chantier = docs[index].data() as Map<String, dynamic>;
              final nom = chantier['nom'] ?? 'Sans nom';
              final adresse = chantier['adresse'] ?? 'Sans adresse';
              return ListTile(
                title: Text(nom),
                subtitle: Text(adresse),
              );
            },
          );
        },
      ),
    );
  }
}
