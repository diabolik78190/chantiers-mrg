import 'package:flutter/material.dart';
import 'ajout_materiel_page.dart';

class GestionMaterielPage extends StatefulWidget {
  const GestionMaterielPage({super.key});

  @override
  State<GestionMaterielPage> createState() => _GestionMaterielPageState();
}

class _GestionMaterielPageState extends State<GestionMaterielPage> {
  List<Map<String, dynamic>> materiels = [
    {'nom': 'Perceuse', 'quantite': 5, 'description': 'Perceuse électrique'},
    {'nom': 'Marteau', 'quantite': 10, 'description': 'Marteau standard'},
  ];

  void _ajouterMateriel() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AjoutMaterielPage()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        materiels.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion du matériel'),
      ),
      body: ListView.builder(
        itemCount: materiels.length,
        itemBuilder: (context, index) {
          final materiel = materiels[index];
          return ListTile(
            title: Text(materiel['nom']),
            subtitle: Text('Quantité : ${materiel['quantite']}\n${materiel['description']}'),
            isThreeLine: true,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ajouterMateriel,
        child: const Icon(Icons.add),
        tooltip: 'Nouveau matériel',
      ),
    );
  }
}
