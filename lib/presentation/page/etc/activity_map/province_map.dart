import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:party_maker/core/constant.dart';

class ProvinceSubPolygon {
  final List<LatLng> outer;
  final List<List<LatLng>> holes;
  ProvinceSubPolygon(this.outer, this.holes);
}

class ProvinceShape {
  final String name;
  final List<ProvinceSubPolygon> parts;
  final LatLng labelPoint;
  ProvinceShape(this.name, this.parts, this.labelPoint);
}

class ProvinceMap extends StatefulWidget {
  final MapController mapController;
  final String selectedName;
  final void Function(String name) onProvinceSelected;
  const ProvinceMap({
    super.key,
    required this.mapController,
    required this.selectedName,
    required this.onProvinceSelected,
  });

  @override
  State<ProvinceMap> createState() => ProvinceMapState();
}

class ProvinceMapState extends State<ProvinceMap> {
  static const fillUnselected = Color(0xFFFDFDFD);
  static const fillSelected = Color(0xFFAEB5F8);
  static const borderUnselected = Color(0xFF9AA0A6);

  static const shortNames = {
    '서울특별시': '서울',
    '부산광역시': '부산',
    '대구광역시': '대구',
    '인천광역시': '인천',
    '광주광역시': '광주',
    '대전광역시': '대전',
    '울산광역시': '울산',
    '세종특별자치시': '세종',
    '경기도': '경기',
    '강원도': '강원',
    '충청북도': '충북',
    '충청남도': '충남',
    '전라북도': '전북',
    '전라남도': '전남',
    '경상북도': '경북',
    '경상남도': '경남',
    '제주특별자치도': '제주',
  };

  List<ProvinceShape> provinces = [];

  @override
  void initState() {
    super.initState();
    loadProvinces();
  }

  Future<void> loadProvinces() async {
    final raw = await rootBundle.loadString(
      'assets/geo/skorea-provinces-simple.json',
    );
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final features = data['features'] as List<dynamic>;
    final parsed = <ProvinceShape>[];
    for (final feature in features) {
      final name = (feature['properties']['name'] ?? '') as String;
      final geometry = feature['geometry'] as Map<String, dynamic>;
      final type = geometry['type'] as String;
      final coordinates = geometry['coordinates'] as List<dynamic>;
      final parts = <ProvinceSubPolygon>[];
      if (type == 'Polygon') {
        parts.add(buildSubPolygon(coordinates));
      } else if (type == 'MultiPolygon') {
        for (final polygon in coordinates) {
          parts.add(buildSubPolygon(polygon as List<dynamic>));
        }
      }
      parsed.add(ProvinceShape(name, parts, labelPointOf(parts)));
    }
    if (mounted) setState(() => provinces = parsed);
  }

  ProvinceSubPolygon buildSubPolygon(List<dynamic> rings) {
    final outer = ringToLatLng(rings.first as List<dynamic>);
    final holes = <List<LatLng>>[];
    for (int i = 1; i < rings.length; i++) {
      holes.add(ringToLatLng(rings[i] as List<dynamic>));
    }
    return ProvinceSubPolygon(outer, holes);
  }

  List<LatLng> ringToLatLng(List<dynamic> ring) => ring
      .map(
        (point) =>
            LatLng((point[1] as num).toDouble(), (point[0] as num).toDouble()),
      )
      .toList();

  LatLng labelPointOf(List<ProvinceSubPolygon> parts) {
    var biggest = parts.first.outer;
    for (final part in parts) {
      if (part.outer.length > biggest.length) biggest = part.outer;
    }
    double latSum = 0;
    double lngSum = 0;
    for (final point in biggest) {
      latSum += point.latitude;
      lngSum += point.longitude;
    }
    return LatLng(latSum / biggest.length, lngSum / biggest.length);
  }

  bool ringContains(LatLng tap, List<LatLng> ring) {
    bool inside = false;
    for (int i = 0, j = ring.length - 1; i < ring.length; j = i++) {
      final xi = ring[i].longitude;
      final yi = ring[i].latitude;
      final xj = ring[j].longitude;
      final yj = ring[j].latitude;
      final intersect = ((yi > tap.latitude) != (yj > tap.latitude)) &&
          (tap.longitude < (xj - xi) * (tap.latitude - yi) / (yj - yi) + xi);
      if (intersect) inside = !inside;
    }
    return inside;
  }

  void onMapTapped(TapPosition tapPosition, LatLng point) {
    for (final province in provinces) {
      for (final part in province.parts) {
        if (ringContains(point, part.outer)) {
          widget.onProvinceSelected(province.name);
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (provinces.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    final polygons = <Polygon>[];
    for (final province in provinces) {
      final selected = province.name == widget.selectedName;
      for (final part in province.parts) {
        polygons.add(
          Polygon(
            points: part.outer,
            holePointsList: part.holes,
            color: selected ? fillSelected : fillUnselected,
            borderColor: selected ? appPrimaryColor : borderUnselected,
            borderStrokeWidth: selected ? 1.6 : 0.7,
          ),
        );
      }
    }

    return FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
        initialCameraFit: CameraFit.bounds(
          bounds: LatLngBounds(
            const LatLng(33.0, 125.0),
            const LatLng(38.7, 131.9),
          ),
          padding: const EdgeInsets.all(10),
        ),
        minZoom: 5.0,
        maxZoom: 12.0,
        onTap: onMapTapped,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
          enableMultiFingerGestureRace: true,
          scrollWheelVelocity: 0.005,
        ),
      ),
      children: [
        PolygonLayer(polygons: polygons),
        MarkerLayer(
          markers: [
            for (final province in provinces)
              Marker(
                point: province.labelPoint,
                width: 52,
                height: 18,
                child: Text(
                  shortNames[province.name] ?? province.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333340),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
