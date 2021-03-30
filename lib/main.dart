import 'package:flutter/material.dart';
import 'package:onlinecontact/pageAuth/connexion.dart';
import 'package:onlinecontact/pageAuth/controlAuth.dart';
import 'package:onlinecontact/pageAuth/inscription.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Utilisateur>.value(
      value: StreamProviderAuth().utilisateur,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.amber
        ),
        home: Passerelle(),
      ),
    );
  }
}

