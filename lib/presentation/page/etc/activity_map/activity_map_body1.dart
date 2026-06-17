import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/etc/activity_map/province_map.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

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
          child: Material(
            color: cardColor,
            elevation: 2,
            shadowColor: Colors.black26,
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 68,
              width: screenWidth,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.04),
                    child: Icon(
                      Icons.place_outlined,
                      size: screenWidth * 0.05,
                      color: appPrimaryColor,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.02),
                      child: Text(
                        locationName,
                        style: TextStyle(
                          fontSize: screenWidth * 0.044,
                          fontWeight: FontWeight.w700,
                          color: cardInk,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Material(
          color: const Color(0xFFEAEFF4),
          elevation: 2,
          shadowColor: Colors.black26,
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 380,
            width: screenWidth,
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
