
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlinecontact/pageAuth/laisonAuth.dart';
import 'package:onlinecontact/pageCrud/accueil.dart';
import 'package:provider/provider.dart';

class Utilisateur{
  String idUtil;
  Utilisateur({this.idUtil});
}

class DonneesUtil{
  String email;
  String nomComplet;
  DonneesUtil({
    this.email, this.nomComplet
});
}

class StreamProviderAuth{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Utilisateur _utilisateurDeFirebaseUser(FirebaseUser user){
    return user != null ? Utilisateur(idUtil: user.uid ) : null;
  }

  Stream<Utilisateur> get utilisateur {
    return _auth.onAuthStateChanged.map(_utilisateurDeFirebaseUser) ;
  }
}

class Passerelle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);
    if(utilisateur == null){
      return LaisonAuth();
    }else{
      return Accueil();
    }
  }
}

class GetCurrentUserData{
  String idUtil;
  GetCurrentUserData({this.idUtil});
  final CollectionReference collectionUtil = Firestore.instance.collection('utilisateurs');
  DonneesUtil _donneesUtilDeSnapshot(DocumentSnapshot snapshot){
    return DonneesUtil(
      nomComplet: snapshot['nomComplet'],
      email: snapshot['emailUtil'],
    );
  }

  Stream<DonneesUtil> get donneesUtil {
    return collectionUtil.document(idUtil).snapshots().map(_donneesUtilDeSnapshot);

  }

}
