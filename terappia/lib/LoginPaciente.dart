import 'package:flutter/material.dart';
import 'package:terappia/TelaInicial.dart';
import 'main.dart';

main() {
  runApp(new telaLoginPaciente());
}

class telaLoginPaciente extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: telaLoginPaciente1(),
    );
  }
}

class telaLoginPaciente1 extends StatefulWidget {
  @override
  telaLoginPacienteState createState() {
    return telaLoginPacienteState();
  }
}

class telaLoginPacienteState extends State<telaLoginPaciente1> {
  TelaInicial telaInicial = new TelaInicial();
  telaBotao telabotao = new telaBotao();
  String user = "";
  String password = "";

  void onLogin() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaInicial()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Color.fromRGBO(231, 254, 255, 1),
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
                          "images/logo.png",
                          width: 300,
                          height: 300,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
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
                              labelText: "Digite sua chave de acesso",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: ElevatedButton(
                            onPressed: onLogin,
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(
                                        width: 3, color: Colors.purple)),
                              ),
                            ),
                            child: const Text("LOGIN",
                                style: TextStyle(fontSize: 25),
                                selectionColor: Colors.purple),
                          ),
                        )
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
