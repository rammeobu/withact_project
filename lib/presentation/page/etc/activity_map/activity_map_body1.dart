import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:party_maker/presentation/page/etc/activity_map/province_map.dart';

class ActivityMapBody1 extends StatelessWidget {
  final MapController mapController;
  final String locationName;
  final String selectedName;
  final void Function(String name) onProvinceSelected;
  const ActivityMapBody1({
    super.key,
    required this.mapController,
    required this.onProvinceSelected,
    this.locationName = '',
    this.selectedName = '',
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
          height: 380,
          width: screenWidth,
          decoration: BoxDecoration(
            color: const Color(0xFFEAEFF4),
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(screenWidth * 0.049),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.049),
            child: ProvinceMap(
              mapController: mapController,
              selectedName: selectedName,
              onProvinceSelected: onProvinceSelected,
            ),
          ),
        ),
      ],
    );
  }
}
