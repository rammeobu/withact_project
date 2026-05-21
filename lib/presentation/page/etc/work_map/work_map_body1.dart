import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WorkMapBody1 extends StatelessWidget {
  final MapController mapController;
  final String locationName;
  const WorkMapBody1({
    super.key,
    required this.mapController,
    this.locationName = '',
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Container(
            height: 68,
            width: screenWidth,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(screenWidth * 0.049),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.024),
                child: Text(
                  locationName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.044,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 253,
          width: screenWidth,
          decoration: BoxDecoration(
            color: const Color(0xFFB4B4B4),
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(screenWidth * 0.049),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.049),
            child: FlutterMap(
              mapController: mapController,
              options: const MapOptions(
                initialZoom: 13.0,
                initialCenter: LatLng(37.5665, 126.9780),
                interactionOptions: InteractionOptions(
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
                const MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(37.5665, 126.9780),
                      width: 45.0,
                      height: 45.0,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.purple,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
