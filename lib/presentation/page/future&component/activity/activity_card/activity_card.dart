import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

const Color _cardInk = Color(0xFF20232A);
const Color _cardSub = Color(0xFF8A8F98);
const Color _chipBg = Color(0xFFEAF2FE);

Widget _poster(String? poster, double screenWidth, double height) {
  final bool hasImage = poster != null && poster.startsWith('http');
  return Container(
    height: height,
    width: double.infinity,
    color: posterColor,
    child: hasImage
        ? Image.network(
            poster,
            fit: BoxFit.cover,
            cacheWidth: 600,
            loadingBuilder: (context, child, progress) => progress == null
                ? child
                : const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
            errorBuilder: (context, error, stackTrace) =>
                _posterEmpty(screenWidth),
          )
        : _posterEmpty(screenWidth),
  );
}

Widget _posterEmpty(double screenWidth) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFEAF2FE), Color(0xFFCFE2FB)],
      ),
    ),
    child: Center(
      child: Icon(
        Icons.groups_rounded,
        size: screenWidth * 0.16,
        color: const Color(0xFF9BBEF0),
      ),
    ),
  );
}

Widget _infoRow(IconData icon, String text, double screenWidth) {
  return Row(
    children: [
      Icon(icon, size: screenWidth * 0.042, color: _cardSub),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: screenWidth * 0.034, color: _cardSub),
          ),
        ),
      ),
    ],
  );
}

Widget _roleChips(List<String> position, double screenWidth) {
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: position
        .take(4)
        .map(
          (roleName) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _chipBg,
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
            ),
            child: Text(
              roleName,
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w600,
                color: appPrimaryColor,
              ),
            ),
          ),
        )
        .toList(),
  );
}

class ActivityCardBasic extends StatelessWidget {
  final String name;
  final String? poster;
  final List<String> timePlace;
  final List<String> position;
  final VoidCallback onTap;

  const ActivityCardBasic({
    super.key,
    required this.name,
    this.poster,
    required this.timePlace,
    required this.position,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final String date = timePlace.isNotEmpty ? timePlace[0] : '';
    final String place = timePlace.length > 1 ? timePlace[1] : '';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: 6),
      child: Material(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 410,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _poster(poster, screenWidth, 196),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.045,
                      14,
                      screenWidth * 0.045,
                      16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w800,
                                color: _cardInk,
                                height: 1.25,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: _infoRow(
                                Icons.event_outlined,
                                date.isEmpty ? '기간 미정' : date,
                                screenWidth,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: _infoRow(
                                Icons.place_outlined,
                                place.isEmpty ? '장소 미정' : place,
                                screenWidth,
                              ),
                            ),
                          ],
                        ),
                        if (position.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: _roleChips(position, screenWidth),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActivityCardApply extends StatelessWidget {
  final String name;
  final String? poster;
  final List<String> timePlace;
  final String applyStatus;
  final VoidCallback? onDetailButtonPressed;
  final VoidCallback? onProfileCheckPressed;
  const ActivityCardApply({
    super.key,
    required this.name,
    this.poster,
    required this.timePlace,
    required this.applyStatus,
    required this.onDetailButtonPressed,
    required this.onProfileCheckPressed,
  });

  Color get _statusColor {
    if (applyStatus.contains('합격') && !applyStatus.contains('불')) {
      return const Color(0xFF1AB97A);
    }
    if (applyStatus.contains('불합격')) return const Color(0xFFF34343);
    return _cardSub;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final String date = timePlace.isNotEmpty ? timePlace[0] : '';
    final String place = timePlace.length > 1 ? timePlace[1] : '';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: 6),
      child: Material(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 410,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _poster(poster, screenWidth, 168),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.045,
                    14,
                    screenWidth * 0.045,
                    10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.048,
                                    fontWeight: FontWeight.w800,
                                    color: _cardInk,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  applyStatus,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: _infoRow(
                              Icons.event_outlined,
                              date.isEmpty ? '기간 미정' : date,
                              screenWidth,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: _infoRow(
                              Icons.place_outlined,
                              place.isEmpty ? '장소 미정' : place,
                              screenWidth,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: onDetailButtonPressed,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: appPrimaryColor,
                                side: const BorderSide(color: appPrimaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.03,
                                  ),
                                ),
                              ),
                              child: Text(
                                '활동 설명',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.034,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ElevatedButton(
                                onPressed: onProfileCheckPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: appPrimaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.03,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '지원서 확인',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.034,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
