import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'CustomMarker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<TelaInicial> {
  late final MapController mapController;
  late LocationData currentLocation;
  double? lat, long;
  Set<Marker> markers = {};
  List<LatLng> routPoints = [LatLng(52.05884, -1.345583)];
  final Icon markerIcon = Icon(Icons.pin_drop, color: Colors.blue, size: 40);

  @override
  void initState() {
    mapController = MapController();
    getCurrentLocation();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(231, 254, 255, 1),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('FloatingActionButton pressed ...');
          },
          backgroundColor: Colors.purple,
          elevation: 8,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 24,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          automaticallyImplyLeading: false,
          title: Text(
            'Bom dia, Nome!',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [
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
                width: 396,
                height: 303,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
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
                  width: 355,
                  height: 327,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      ListTile(
                        title: Text('Title'),
                        subtitle: Text(
                          'Subtitle goes here...',
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
                          'Title',
                        ),
                        subtitle: Text(
                          'Subtitle goes here...',
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
                          'Title',
                        ),
                        subtitle: Text(
                          'Subtitle goes here...',
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
                          'Title',
                        ),
                        subtitle: Text(
                          'Subtitle goes here...',
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
                        title: Text('Title'),
                        subtitle: Text(
                          'Subtitle goes here...',
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
      ),
    );
  }
}
