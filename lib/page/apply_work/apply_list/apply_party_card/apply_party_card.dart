import 'package:flutter/material.dart';

import '../../../future&component/layout/default_container.dart';
import 'apply_party_card_button.dart';
import 'apply_party_card_middle.dart';

class ApplyPartyCard extends StatelessWidget {
  final String name;
  final List<String> timePlace;
  final String applyStatus;
  const ApplyPartyCard({
    super.key,
    required this.name,
    required this.timePlace,
    required this.applyStatus,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20.0),
          ),
          color: Color(0xFFFDFDFD),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment(0, 0),
                    child: DefaultContainer(
                      height: 70,
                      width: 70,
                      color: Color(0xffe3e5e9),
                      child: Center(child: Text('포스터')),
                    ),
                  ),
                ),
                ApplyPartyCardMiddle(
                  name: name,
                  timePlace: timePlace,
                ),
                Expanded(flex: 2, child: ApplyPartyCardButton(applyStatus: applyStatus,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
