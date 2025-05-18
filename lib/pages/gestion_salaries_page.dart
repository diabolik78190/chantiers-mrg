import 'package:flutter/material.dart';

class GestionSalariesPage extends StatefulWidget {
  const GestionSalariesPage({super.key});

  @override
  State<GestionSalariesPage> createState() => _GestionSalariesPageState();
}

class _GestionSalariesPageState extends State<GestionSalariesPage> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final List<Map<String, String>> _salaries = [];

  void _ajouterSalarie() {
    final nom = _nomController.text.trim();
    final email = _emailController.text.trim();

    if (nom.isNotEmpty && email.isNotEmpty) {
      setState(() {
        _salaries.add({'nom': nom, 'email': email});
        _nomController.clear();
        _emailController.clear();
      });
    }
  }

  void _supprimerSalarie(int index) {
    setState(() {
      _salaries.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des salariés'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom du salarié'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ajouterSalarie,
              child: const Text('Ajouter le salarié'),
            ),
            const SizedBox(height: 30),
            const Text(
              'Liste des salariés',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _salaries.length,
                itemBuilder: (context, index) {
                  final salarie = _salaries[index];
                  return ListTile(
                    title: Text(salarie['nom']!),
                    subtitle: Text(salarie['email']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _supprimerSalarie(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
