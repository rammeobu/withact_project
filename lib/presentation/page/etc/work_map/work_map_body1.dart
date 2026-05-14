import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WorkMapBody1 extends StatefulWidget {
  final MapController mapController;
  const WorkMapBody1({super.key, required this.mapController});

  @override
  State<WorkMapBody1> createState() => _WorkMapBody1State();
}

class _WorkMapBody1State extends State<WorkMapBody1> {
  String region = '';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
          child: Container(
            height: screenHeight * 0.08,
            width: screenWidth,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(region),
              ),
            ),
          ),
        ),
        Container(
          height: screenHeight * 0.3,
          width: screenWidth,
          decoration: BoxDecoration(
            color: Color(0xFFB4B4B4),
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FlutterMap(
              mapController: widget.mapController,
              options: MapOptions(
                initialZoom: 13.0,
                initialCenter: LatLng(37.5665, 126.9780),
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all,
                  enableMultiFingerGestureRace: true,
                  scrollWheelVelocity: 0.005,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.party_maker',
                  errorTileCallback: (tile, error, stackTrace) {},
                  evictErrorTileStrategy: EvictErrorTileStrategy.none,
                  tileBuilder: (context, tileWidget, tile) {
                    return Container(color: Colors.white, child: tileWidget);
                  },
                  additionalOptions: const {
                    'User-Agent': 'com.party_maker.app',
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
