import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CustomMarker extends Marker {
  CustomMarker({
    required LatLng point,
    required Icon icon,
    String? width,
    String? height,
    AnchorPos? anchorPos,
    bool rotate = false,
  }) : super(
          point: point,
          builder: (BuildContext context) {
            return Icon(
              icon.icon,
              color: icon.color,
              size: icon.size,
            );
          },
          anchorPos: anchorPos,
          rotate: rotate,
        );
}