import 'package:flutter/material.dart';

main() {
  runApp(new telaLogin());
}

class telaLogin extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: telaLogin1(),
    );
    
  }
}
class telaLogin1 extends StatefulWidget {
  @override
  telaLoginState createState() {
    return telaLoginState();
  }
}

class telaLoginState extends State<telaLogin1> {

  String user = "";
  String password = "";
  void onLogin() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color.fromARGB(255, 68, 202, 255),
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
                TextField(
                  onChanged: (text) {
                    user = text;
                  },
                  decoration: InputDecoration(labelText: "Usuário"),
                ),

                TextField(
                  onChanged: (text) {
                    password = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Senha"),
                ),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: ElevatedButton(
                  onPressed: onLogin,
                  child: const Text("Login", style: TextStyle(fontSize: 25), selectionColor: Colors.purple),
                ),
                )

              ],
            )
          )
            
            
            
          
        )
        )
    );
  }
}
