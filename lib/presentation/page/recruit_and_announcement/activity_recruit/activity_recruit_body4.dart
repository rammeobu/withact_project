import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/etc/activity_map/province_map.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class ActivityRecruitBody4 extends StatelessWidget {
  final MapController mapController;
  final String selectedRegion;
  final void Function(String name) onRegionSelected;

  const ActivityRecruitBody4({
    super.key,
    required this.mapController,
    required this.selectedRegion,
    required this.onRegionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final shortName = ProvinceMapState.shortNames[selectedRegion] ?? '';
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '모집 지역',
                style: TextStyle(
                  fontSize: screenWidth * 0.058,
                  fontWeight: FontWeight.w800,
                  color: cardInk,
                ),
              ),
              if (shortName.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    shortName,
                    style: TextStyle(
                      fontSize: screenWidth * 0.041,
                      fontWeight: FontWeight.w600,
                      color: appPrimaryColor,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                border: Border.all(color: const Color(0xFFE0E3E8)),
              ),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedRegion.isEmpty ? null : selectedRegion,
                  hint: Text(
                    '시 / 도로 선택',
                    style: TextStyle(
                      fontSize: screenWidth * 0.041,
                      color: cardSub,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: appPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  items: ProvinceMapState.shortNames.keys
                      .map(
                        (name) => DropdownMenuItem<String>(
                          value: name,
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: screenWidth * 0.041,
                              color: cardInk,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) onRegionSelected(value);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Material(
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
                  selectedName: selectedRegion,
                  onProvinceSelected: onRegionSelected,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
