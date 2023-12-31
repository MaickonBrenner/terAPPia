import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:terappia/TelaInicial.dart';
import 'package:terappia/main.dart';
import 'package:terappia/services/database.dart';
import 'package:terappia/telaRegistro.dart';

class telaLogin extends StatelessWidget {
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: telaLogin1(),
    );
  }
}

class telaLogin1 extends StatefulWidget {
  const telaLogin1({Key? key}) : super(key: key);
  @override
  telaLoginState createState() {
    return telaLoginState();
  }
}

class telaLoginState extends State<telaLogin1> {
  TelaInicial telaInicial = new TelaInicial();
  telaBotao telabotao = new telaBotao();
  String email = "";
  String nome = "";
  String username = "";
  String password = "";
  String id = "";

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  onLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

QuerySnapshot querySnapshot = await DatabaseMethods().getUserbyemail(email);

nome ="${querySnapshot.docs[0]["Nome"]}";
username = "${querySnapshot.docs[0]["Username"]}";
id = querySnapshot.docs[0].id;

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TelaInicial()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Nenhum Usuário Encontrado com este Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      } else if (e.code == 'wrong-passoword') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Senha errada",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Color.fromRGBO(231, 254, 255, 1),
          fontFamily: 'Montserrat',
        ),
        home: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => telabotao),
                  );
                },
                child: const Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.purpleAccent,
                  size: 32,
                ),
              ),
            ),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/logoprofissional.png",
                          width: 300,
                          height: 300,
                        ),
                        Form(
                          key: _formkey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: emailcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Coloque o Email';
                                }
                                return null;
                              },
                              onChanged: (text) {
                                email = text;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  labelText: "Digite seu e-mail",
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.mail_outline)),
                            ),
                          ),
                        ),
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: passwordcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Coloque a Senha';
                                }
                                return null;
                              },
                              onChanged: (text) {
                                password = text;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10.0)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Digite sua senha",
                                  prefixIcon: const Icon(Icons.password)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => telaRegistro()),
                            );
                          },
                          child: Text(
                            "Ainda não tem uma conta?",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.purple,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: SizedBox(
                              width: ((MediaQuery.of(context).size.width) / 2),
                              height: 45,
                              child: GestureDetector(
                                onTap: () {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      email = emailcontroller.text;
                                      password = passwordcontroller.text;
                                    });
                                  }
                                  onLogin();
                                }, // Defina a função que deseja chamar no toque
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                          width: 3, color: Colors.purple),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          "LOGIN",
                                          style: TextStyle(fontSize: 25, color: Colors.white,)
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    )))));
  }
}
