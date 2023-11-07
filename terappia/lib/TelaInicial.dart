import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

//adicionar outras classes: 

class TelaInicial extends StatelessWidget {
/*
  late final MapController mapController;
  late LocationData currentLocation;
  double? lat, long;
  Set<Marker> markers = {};
  List<LatLng> routPoints = [LatLng(52.05884, -1.345583)];
  final Icon markerIcon = Icon(
    Icons.pin_drop,
    color: Colors.blue,
    size: 40,
  );

  late String origem;
  late String chegada;

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
    markers.clear();
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
      routPoints = [];
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
      print(routPoints);
    });
  }

  void pressionar() {
    print(origem);
    print(chegada);
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 80.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
              ),
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 460,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: EdgeInsets.all(20),
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(51.509364, -0.128928),
                      zoom: 15.0,
                      onTap: ((tapPoition, point) {
                        print(point);
                        //addMarker(point);
                      })),
                    /*mapController: MapController,
                    children: [], */ 
                  ),
                )
              ],
            )
          ],
        ), 
      ),
    );
  }

}