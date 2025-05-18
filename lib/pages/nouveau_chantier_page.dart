import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NouveauChantierPage extends StatefulWidget {
  const NouveauChantierPage({super.key});

  @override
  State<NouveauChantierPage> createState() => _NouveauChantierPageState();
}

class _NouveauChantierPageState extends State<NouveauChantierPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isSaving = false;

  Future<void> _ajouterChantier() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      await FirebaseFirestore.instance.collection('chantiers').add({
        'nom': _nomController.text.trim(),
        'adresse': _adresseController.text.trim(),
        'description': _descriptionController.text.trim(),
        'dateCreation': Timestamp.now(),
        'termine': false,
      });
      // Après ajout, revenir en arrière avec succès
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'ajout du chantier : $e')),
      );
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _adresseController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau Chantier'),
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
                  labelText: 'Nom du chantier',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _adresseController,
                decoration: const InputDecoration(
                  labelText: 'Adresse',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSaving ? null : _ajouterChantier,
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Ajouter le chantier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
