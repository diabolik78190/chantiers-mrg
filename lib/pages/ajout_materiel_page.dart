import 'package:flutter/material.dart';

class AjoutMaterielPage extends StatefulWidget {
  const AjoutMaterielPage({super.key});

  @override
  State<AjoutMaterielPage> createState() => _AjoutMaterielPageState();
}

class _AjoutMaterielPageState extends State<AjoutMaterielPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _quantiteController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _quantiteController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Pour l'instant, on récupère les valeurs mais on ne stocke pas encore
      final String nom = _nomController.text.trim();
      final int quantite = int.parse(_quantiteController.text.trim());
      final String description = _descriptionController.text.trim();

      // Tu peux ici envoyer ces données à Firebase plus tard

      // Affiche un message de confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Matériel ajouté avec succès !')),
      );

      // Retour à la page précédente
      Navigator.pop(context, {
        'nom': nom,
        'quantite': quantite,
        'description': description,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un matériel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom du matériel',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantiteController,
                decoration: const InputDecoration(
                  labelText: 'Quantité',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Veuillez entrer une quantité';
                  }
                  final n = int.tryParse(value);
                  if (n == null || n <= 0) {
                    return 'Veuillez entrer un nombre entier positif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
