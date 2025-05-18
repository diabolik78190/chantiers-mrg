import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ValidationUtilisateursPage extends StatelessWidget {
  const ValidationUtilisateursPage({super.key});

  void validerUtilisateur(String uid) {
    FirebaseFirestore.instance.collection('users').doc(uid).update({'role': 'salarie'});
  }

  void supprimerUtilisateur(String uid) {
    FirebaseFirestore.instance.collection('users').doc(uid).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Validation des utilisateurs")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'en_attente')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("Aucun utilisateur en attente."));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final user = docs[index];
              return ListTile(
                title: Text(user['nom']),
                subtitle: Text(user['email']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => validerUtilisateur(user.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => supprimerUtilisateur(user.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
