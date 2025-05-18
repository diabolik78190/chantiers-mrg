import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/inscription_page.dart';
import 'pages/accueil_page.dart';
import 'firebase_options.dart';
import 'pages/connexion_page.dart';
import 'pages/liste_salaries_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChantiersMRGApp());
}

class ChantiersMRGApp extends StatelessWidget {
  const ChantiersMRGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chantiers-MRG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const ConnexionPage(),
      routes: {
        '/connexion': (context) => const ConnexionPage(),
        '/inscription': (context) => const InscriptionPage(),
        '/accueil': (context) => const AccueilPage(),
        '/liste_salaries': (context) => const ListeSalariesPage(),
      },
    );
  }
}
