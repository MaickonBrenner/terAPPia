import 'package:flutter/material.dart';
import 'package:terappia/chathome.dart';
import 'LoginProfissional.dart';

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [home, share, settings];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);


  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        ChatHome chatHome = new ChatHome();
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => chatHome),
        );
        break;
      case MenuItems.settings: //Configurações
        /*ChatPage chatPage = new ChatPage();
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => chatPage),
          );
        break;*/
      case MenuItems.share:
        /*Calendario calendario = new Calendario();
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => calendario),
        );*/
        break;
      case MenuItems.logout:
      telaLogin telalogin = new telaLogin();
        Navigator.push(
        context as BuildContext,
        MaterialPageRoute(builder: (context) => telalogin),
      );
        break;
    }
  }
}
//https://pub.dev/packages/dropdown_button2