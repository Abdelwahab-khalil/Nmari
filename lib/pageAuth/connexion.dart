

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinecontact/constants/chargement.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Connexion extends StatefulWidget {

  final Function basculation;
  Connexion({this.basculation});
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

  FirebaseAuth _auth = FirebaseAuth.instance;

  String email = '';
  String motDePass = '';

  bool chargement = false;

  final _keyForem = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return chargement ? Chargement() : Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Form(
            key: _keyForem,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/logo.png', height: 100.0, width: 100.0,),
                Center(
                  child: Text(
                    'Bienvenu sur Nmari',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val.isEmpty ? 'Entrer un email' : null,
                  onChanged: (val) => email = val,
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Password incorrect' : null,
                  onChanged: (val) => email = val,
                ),
                SizedBox(height: 10.0,),
                FlatButton(
                    onPressed: () async {
                      if(_keyForem.currentState.validate()){
                        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: motDePass);
                        if(result == null){
                          //error
                        }
                        setState(() => chargement = true);
                      }
                    },
                    color: Colors.blue,
                    child: Text('Connexion'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                ),
                ),
                OutlineButton(
                  onPressed: (){
                    widget.basculation();
                  },
                  borderSide: BorderSide(width: 1.0, color: Colors.blue),
                  child: Text('Inscription'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
