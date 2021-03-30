

import 'package:flutter/material.dart';
import 'package:onlinecontact/pageAuth/connexion.dart';
import 'package:onlinecontact/pageAuth/inscription.dart';

class LaisonAuth extends StatefulWidget {
  @override
  _LaisonAuthState createState() => _LaisonAuthState();
}

class _LaisonAuthState extends State<LaisonAuth> {

  bool affichePageConnexion = true;

  void basculation(){
    setState(() => affichePageConnexion = !affichePageConnexion );
  }

  @override
  Widget build(BuildContext context) {
    if(affichePageConnexion){
      return Connexion(basculation: basculation);
    }else{
      return Inscription(basculation: basculation);
    }
  }
}
