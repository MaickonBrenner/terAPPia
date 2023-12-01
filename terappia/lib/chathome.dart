import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:terappia/LoginProfissional.dart';
import 'package:terappia/NavigationScreen.dart';
import 'dart:async';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:terappia/TelaInicial.dart';
import 'package:terappia/calendar.dart';
import 'package:terappia/chatpage.dart';
import 'package:terappia/services/database.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen
  bool search = false;

  var queryResultSet = [];
  var tempSearchStore = [];

  iniateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    setState(() {
      search = true;
    });
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().Search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Username'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.people,
    Icons.calendar_month,
    Icons.attach_money_rounded,
    Icons.settings,
  ];

  void mudaTela(int index) {
    switch (index) {
      case 0: //Chat
        TelaInicial telaInicial = new TelaInicial();
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => telaInicial),
        );
        break;
      case 1: // calendário
        Calendario calendario = new Calendario();
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => calendario),
        );
        break;
    }

    print(index);
    setState(() => _bottomNavIndex = index);
  }

  @override
  void initState() {
    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    Future.delayed(
      Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 40.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  search
                      ? Expanded(
                          child: TextField(
                          onChanged: (value) {
                            iniateSearch(value.toUpperCase());
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Procurar Usuário',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500)),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                        ))
                      : Text(
                          "Chat",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                  GestureDetector(
                    onTap: () {
                      search = true;
                      setState(() {});
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          Icons.search,
                          color: Colors.purple,
                        )),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              height: search
                  ? MediaQuery.of(context).size.height / 1.19
                  : MediaQuery.of(context).size.height / 100 * 79,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  search
                      ? ListView(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          primary: false,
                          shrinkWrap: true,
                          children: tempSearchStore.map((element) {
                            return buildResultCard(element);
                          }).toList())
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPage()));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.asset(
                                        "images/user.png",
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Profissional 1",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Como posso te ajudar?",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.asset(
                                      "images/user.png",
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Profissional 2",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Olá!",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
        onPressed: () {
          _fabAnimationController.reset();
          _borderRadiusAnimationController.reset();
          _borderRadiusAnimationController.forward();
          _fabAnimationController.forward();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          //final color = isActive ? colors.activeNavigationBarColor : colors.notActiveNavigationBarColor;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  /*child: AutoSizeText(
                    "Botão $index",
                    maxLines: 1,
                    style: TextStyle(color: Colors.white),
                    group: autoSizeGroup,
                  ),*/
                )
            ],
          );
        },
        backgroundColor: Colors.purple,
        activeIndex: _bottomNavIndex,
        splashColor: Colors.white,
        notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          mudaTela(index);
        },
        hideAnimationController: _hideBottomBarAnimationController,
        shadow: const BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 12,
            spreadRadius: 0.5,
            color: Colors.white),
      ),
    );
  }

  Widget buildResultCard(data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data["Nome"],
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0,),
                  Text(data["Username"],style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
