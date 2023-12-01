import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:terappia/calendar.dart';
import 'package:terappia/chathome.dart';
import 'CustomMarker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'LoginProfissional.dart';
import 'MenuItems.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'dart:async';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/rendering.dart';
import 'package:terappia/NavigationScreen.dart';

main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(new TelaInicial());
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<TelaInicial>
    with TickerProviderStateMixin {
  late final MapController mapController;
  late LocationData currentLocation;
  double? lat, long;
  Set<Marker> markers = {};
  List<LatLng> routPoints = [LatLng(52.05884, -1.345583)];
  final Icon markerIcon = Icon(Icons.pin_drop, color: Colors.blue, size: 40);

  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.chat,
    Icons.calendar_month,
    Icons.attach_money_rounded,
    Icons.route,
  ];

  @override
  void initState() {
    mapController = MapController();
    getCurrentLocation();
    super.initState();
    FlutterNativeSplash.remove();

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

  void getCurrentLocation() async {
    var location = Location();
    currentLocation = await location.getLocation();
    lat = currentLocation.latitude;
    long = currentLocation.longitude;
    setState(() {
      mapController.move(LatLng(lat!, long!), 15.0);
    });
  }

  void addMarker(LatLng point) async {
    /* final marker = CustomMarker(
      point: point,
      icon: markerIcon,
    );
    markers.add(marker);*/
    //markers.clear();
    final marker = CustomMarker(
      point: point,
      icon: markerIcon,
    );
    var longFinal = point.longitude;
    var latFinal = point.latitude;
    var url = Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/$long,$lat;$longFinal,$latFinal?steps=true&annotations=true&geometries=geojson&overview=full');
    var response = await http.get(url);
    print(response.body);
    setState(() {
      markers.add(marker);
      /* routPoints = [];
      var ruter =
          jsonDecode(response.body)['routes'][0]['geometry']['coordinates'];
      for (int i = 0; i < ruter.length; i++) {
        var reep = ruter[i].toString();
        reep = reep.replaceAll("[", "");
        reep = reep.replaceAll("]", "");
        var lat1 = reep.split(',');
        var long1 = reep.split(",");
        routPoints.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
      }
      print(routPoints);*/
    });
  }

  telaLogin telalogin = new telaLogin();

  void deslogar() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => telalogin),
      );
    });
  }


  void mudaTela(int index){
    switch(index) {
      case 0: //Chat
        ChatHome chatHome = new ChatHome();
        Navigator.push(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => chatHome),
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
    setState(() => 
          _bottomNavIndex = index
    );


  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(231, 254, 255, 1),
        /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('FloatingActionButton pressed ...');
          },
          backgroundColor: Colors.purple,
          elevation: 8,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 24,
          ),
        ),*/
        appBar: AppBar(
          backgroundColor: Colors.purple,
          automaticallyImplyLeading: false,
          title: Text(
            'Bom dia, Profissional  !',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: const Icon(
                  Icons.list,
                  size: 46,
                  color: Colors.white,
                ),
                items: [
                  ...MenuItems.firstItems.map(
                    (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),
                  const DropdownMenuItem<Divider>(
                      enabled: false, child: Divider()),
                  ...MenuItems.secondItems.map(
                    (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),
                ],
                onChanged: (value) {
                  MenuItems.onChanged(context, value! as MenuItem);
                },
                dropdownStyleData: DropdownStyleData(
                  width: 160,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.purple,
                  ),
                  offset: const Offset(0, 8),
                ),
                menuItemStyleData: MenuItemStyleData(
                  customHeights: [
                    ...List<double>.filled(MenuItems.firstItems.length, 48),
                    8,
                    ...List<double>.filled(MenuItems.secondItems.length, 48),
                  ],
                  padding: const EdgeInsets.only(left: 16, right: 16),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "images/logoterappia.png",
                width: 60,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: ((MediaQuery.of(context).size.width) / 100 * 95),
                height: ((MediaQuery.of(context).size.height / 100 * 40)),
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: FlutterMap(
                    options: MapOptions(
                        center: LatLng(51.509364, -0.128928),
                        zoom: 15.0,
                        onTap: ((tapPosition, point) {
                          print(point);
                          addMarker(point);
                        })),
                    mapController: mapController,
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                      MarkerLayer(
                        markers: markers.toList(),
                      ),
                      PolylineLayer(
                        polylineCulling: false,
                        polylines: [
                          Polyline(
                              points: routPoints,
                              color: Colors.blueAccent,
                              strokeWidth: 8.0)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                child: Container(
                  width: ((MediaQuery.of(context).size.width) / 100 * 95),
                  height: ((MediaQuery.of(context).size.height / 100 * 40)),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      ListTile(
                        title: Text('Nome do Paciente'),
                        subtitle: Text(
                          'distância',
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 20,
                        ),
                        tileColor: Colors.white,
                        dense: false,
                      ),
                      ListTile(
                        title: Text(
                          'Nome do Paciente',
                        ),
                        subtitle: Text(
                          'distância',
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 20,
                        ),
                        tileColor: Colors.white,
                        dense: false,
                      ),
                      ListTile(
                        title: Text(
                          'Nome do Paciente',
                        ),
                        subtitle: Text(
                          'distância',
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 20,
                        ),
                        tileColor: Colors.white,
                        dense: false,
                      ),
                      ListTile(
                        title: Text(
                          'Nome do Paciente',
                        ),
                        subtitle: Text(
                          'distância',
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 20,
                        ),
                        tileColor: Colors.white,
                        dense: false,
                      ),
                      ListTile(
                        title: Text('Nome do Paciente'),
                        subtitle: Text(
                          'distância',
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                          size: 20,
                        ),
                        tileColor: Colors.white,
                        dense: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        /* NotificationListener<ScrollNotification>(
        onNotification: onScrollNotification,
        child: NavigationScreen(iconList[_bottomNavIndex]),
      ),*/
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: const Icon(
            Icons.people,
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
          onTap:(index) {
            mudaTela(index);
          },
          hideAnimationController: _hideBottomBarAnimationController,
          shadow: const BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 12,
              spreadRadius: 0.5,
              color: Colors.white),
        ),
      ),
    );
  }
}
