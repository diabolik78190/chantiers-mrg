import 'package:flutter/material.dart';
import 'detail_chantier_page.dart'; // N'oublie pas l'import

class ListeChantiersEnCoursPage extends StatelessWidget {
  const ListeChantiersEnCoursPage({Key? key}) : super(key: key);

  // Exemple de données en dur pour tester
  final List<Map<String, String>> chantiers = const [
    {'id': '1', 'nom': 'Chantier A'},
    {'id': '2', 'nom': 'Chantier B'},
    {'id': '3', 'nom': 'Chantier C'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chantiers en cours'),
      ),
      body: ListView.builder(
        itemCount: chantiers.length,
        itemBuilder: (context, index) {
          final chantier = chantiers[index];
          return ListTile(
            leading: Icon(Icons.construction),
            title: Text(chantier['nom']!),
            onTap: () {
              // Ici on navigue vers la page détail chantier en passant id et nom
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailChantierPage(
                    chantierId: chantier['id']!,
                    chantierNom: chantier['nom']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
