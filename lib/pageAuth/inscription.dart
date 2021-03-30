
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Inscription extends StatefulWidget {

  final Function basculation;
  Inscription({this.basculation});

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser currentUtil;

  final CollectionReference collectionUtil = Firestore.instance.collection('utilisateurs');

  String nomComplet = '';
  String email = '';
  String motDePass = '';
  String ConfimMDP = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    FirebaseAuth.instance.currentUser().then((FirebaseUser util){
      setState(() {
        this.currentUtil = util;
      });
    });
    String idUtil(){
      if(currentUtil != null){
        return currentUtil.uid;
      }else{
        return "pas d'utlisation courant";
      }
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              SizedBox(height: 50.0,),
            Image.asset('assets/logo.png', height: 100.0, width: 100.0),
            Center(
              child: Text('Creer Un compte sur Nmari',
                style: Theme.of(context).textTheme.title, ),
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Nom complet',
                  border: OutlineInputBorder()
              ),
              validator: (val) => val.isEmpty ? 'Entrer un nom' : null,
              onChanged: (val) => nomComplet = val,
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder()
              ),
              validator: (val) => val.isEmpty ? 'Entrer un email' : null,
              onChanged: (val) => email = val,
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder()
              ),
              obscureText: true,
              validator: (val) => val.length < 6 ? 'le mot de passe doit contient plus de 6 caractere' : null,
              onChanged: (val) => motDePass = val,
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  border: OutlineInputBorder()
              ),
              obscureText: true,
              onChanged: (val) => ConfimMDP = val,
              validator: (val) => ConfimMDP != motDePass ? 'mot de pass ne confirm pas' : null,

            ),
            SizedBox(height: 15.0,),
            FlatButton(
              onPressed: () async {
              if(_formKey.currentState.validate()){
                AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: motDePass);
                await collectionUtil.document(idUtil()).setData({
                    'idUtil': idUtil(),
                    'nomComplet': nomComplet,
                    'emailUtil' : email,
                });
                if(result == null){
                  //error
                }
              }
            },
              color: Colors.amber,
              child: Text('S\'inscrire'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
              ),
            ),
            SizedBox(height: 10.0,),
            OutlineButton(onPressed: (){
              widget.basculation();
            },
              color: Colors.amber,
              borderSide: BorderSide(width: 1.0, color: Colors.blue),
              child: Text('Avez-vous deja un compte'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
              ),
            ),
            ]
          )

        ),
        ),
      ),
    );
  }
}
