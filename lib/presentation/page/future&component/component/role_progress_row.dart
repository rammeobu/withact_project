import 'package:flutter/material.dart';

class RoleProgressRow extends StatelessWidget {
  final String roleName;
  final int target;
  final int current;
  final double fontSize;
  const RoleProgressRow({
    super.key,
    required this.roleName,
    required this.target,
    required this.current,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final count = target < 1 ? 1 : target;
    final filled = current < 0 ? 0 : (current > count ? count : current);
    final ratio = filled / count;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth * 0.16,
            child: Text(
              roleName,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(color: const Color(0xFFECEDEF)),
                    ),
                    Positioned.fill(
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: ratio,
                        child: Container(color: const Color(0xFF059568)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.03),
            child: Text(
              '$current / $count',
              style: TextStyle(
                fontSize: fontSize,
                color: const Color(0xFF636370),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
