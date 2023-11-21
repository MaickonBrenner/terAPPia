import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(231, 254, 255, 1),
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 120.0,
                  ),
                  Text(
                    "Profissional",
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0, bottom: 40.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2),
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Text(
                    "Olá! Como você está?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 30.0,),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 2),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Text(
                    "Estou bem!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Spacer(),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                    child: Row(children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Digite sua mensagem",hintStyle:TextStyle(color: Colors.black45) ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Color.fromARGB(255, 202, 193, 193), borderRadius: BorderRadius.circular(60)),
                      child: Center(child: Icon(Icons.send,color: Colors.blueAccent,)))
                  ],),),
                )
              ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
