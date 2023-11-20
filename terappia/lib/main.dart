import 'package:flutter/material.dart';
import 'package:terappia/TelaInicial.dart';
import 'LoginProfissional.dart';
import 'LoginPaciente.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(new telaBotao());
}

class telaBotao extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: telaBotaoState(),
    );
  }
}

class telaBotaoState extends StatefulWidget {
  @override
  State<telaBotaoState> createState() => telaBotao1State();
}

class telaBotao1State extends State<telaBotaoState> {
  TelaInicial telaInicial = new TelaInicial();
  telaLogin telalogin = new telaLogin();
  telaLoginPaciente telaloginpaciente = new telaLoginPaciente();
  String user = "";
  String password = "";

  void onLogin() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => telalogin),
      );
    });
  }

  void onLoginPaciente() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => telaloginpaciente),
      );
    });
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
            /*appBar: AppBar(
          title: Text("terAPPia")
        ),*/

            body: Center(
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/logo.png",
                          width: 300,
                          height: 300,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                                width: ((MediaQuery.of(context).size.width) /
                                    3 *
                                    2),
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: onLogin,
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0), //60.0 (Borda Redonda)
                                          side: BorderSide(
                                              width: 3, color: Colors.purple)),
                                    ),
                                  ),
                                  child: const Text("Sou profissional",
                                      style: TextStyle(fontSize: 25),
                                      selectionColor: Colors.purple),
                                ))),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                                width: ((MediaQuery.of(context).size.width) /
                                    3 *
                                    2),
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: onLoginPaciente,
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                              width: 3, color: Colors.purple)),
                                    ),
                                  ),
                                  child: const Text("Sou paciente",
                                      style: TextStyle(fontSize: 25),
                                      selectionColor: Colors.purple),
                                ))),
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