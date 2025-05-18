import 'package:flutter/material.dart';

class DetailChantierPage extends StatefulWidget {
  final String chantierId;
  final String chantierNom;

  const DetailChantierPage({required this.chantierId, required this.chantierNom, Key? key}) : super(key: key);

  @override
  _DetailChantierPageState createState() => _DetailChantierPageState();
}

class _DetailChantierPageState extends State<DetailChantierPage> {
  List<String> materielPresent = [];
  List<String> materielNecessaire = [];
  List<String> materielACommander = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chantier: ${widget.chantierNom}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionMateriel('Matériel sur le chantier', materielPresent),
            SizedBox(height: 20),
            sectionMateriel('Matériel nécessaire', materielNecessaire),
            SizedBox(height: 20),
            sectionMateriel('Matériel à commander', materielACommander),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.send),
              label: Text('Envoyer la commande au fournisseur'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fonction d\'envoi non encore implémentée')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionMateriel(String titre, List<String> liste) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titre, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ...liste.map((item) => ListTile(title: Text(item))).toList(),
        ElevatedButton(
          onPressed: () {
            _ajouterMateriel(titre, liste);
          },
          child: Text('Ajouter'),
        ),
      ],
    );
  }

  void _ajouterMateriel(String titre, List<String> liste) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Ajouter au $titre'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Nom du matériel'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              final texte = controller.text.trim();
              if (texte.isNotEmpty) {
                setState(() {
                  liste.add(texte);
                });
              }
              Navigator.pop(context);
            },
            child: Text('Ajouter'),
          ),
        ],
      ),
    );
  }
}
