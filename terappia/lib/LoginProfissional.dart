import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:terappia/TelaInicial.dart';
import 'package:terappia/main.dart';

class telaLogin extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
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
  String password = "";

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController senhacontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  onLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);          
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
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.purpleAccent,
                  size: 32,
                ),
              ),
            ),
            body: Center(
                child: Padding(
                    padding: EdgeInsets.all(16.0),
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
                                  prefixIcon: Icon(Icons.mail_outline)),
                            ),
                          ),
                        ),
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: senhacontroller,
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
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10.0)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Digite sua senha",
                                  prefixIcon: Icon(Icons.password)),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: SizedBox(
                                width:
                                    ((MediaQuery.of(context).size.width) / 2),
                                height: 45,
                                child: GestureDetector(
                                  onTap:(){
                                    if(_formkey.currentState!.validate()){
                                      setState(() {
                                        email = emailcontroller.text;
                                        password= senhacontroller.text;
                                      });
                                    }
                                    onLogin();
                                  }, // Defina a função que deseja chamar no toque
                                  child: Container(
                                    decoration: 
                                    BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                          width: 3, color: Colors.purple),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                  ),
                                )))
                      ],
                    )))));
  }
}

/* Referências:

https://www.arquivodecodigos.com.br/dicas/3761-flutter-aprenda-a-usar-caixas-de-texto-textfield-em-suas-aplicacoes-flutter.html
https://www.flutterbeads.com/elevated-button-color-in-flutter/
https://capsistema.com.br/index.php/2022/08/22/borda-do-botao-adicionar-personalizar-no-flutter-guia-definitivo-de-2022/
https://www.flutterbeads.com/change-textfield-background-color-in-flutter/
https://pt.stackoverflow.com/questions/463662/flutter-como-alterar-o-tamanho-de-um-textfield-corretamente
https://www.linkedin.com/pulse/como-colocar-imagem-em-flutter-caroline-souza/?originalSubdomain=pt
https://docs.flutter.dev/cookbook/navigation/navigation-basics

 Tipos de Text:
decoration: InputDecoration(labelText: "Usuário")

=> Bordas arredondadas
TextField(
                  onChanged: (text) {
                    password = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(60)),
                      hintText: "Digite sua senha",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                ),
*/