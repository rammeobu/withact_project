import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

const Color cardInk = Color(0xFF20232A);
const Color cardSub = Color(0xFF8A8F98);
const Color cardChipBg = Color(0xFFEAF2FE);
const Color cardPosterIcon = Color(0xFFB7BDC6);

Widget _empty(double screenWidth, double iconSize) {
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
        size: iconSize * 1.4,
        color: const Color(0xFF9BBEF0),
      ),
    ),
  );
}

Widget cardPoster(String? poster, double screenWidth, double height) {
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
                _empty(screenWidth, screenWidth * 0.12),
          )
        : _empty(screenWidth, screenWidth * 0.12),
  );
}

Widget cardThumb(String? poster, double screenWidth, double size) {
  final bool hasImage = poster != null && poster.startsWith('http');
  return ClipRRect(
    borderRadius: BorderRadius.circular(screenWidth * 0.03),
    child: Container(
      width: size,
      height: size,
      color: posterColor,
      child: hasImage
          ? Image.network(
              poster,
              fit: BoxFit.cover,
              cacheWidth: 300,
              errorBuilder: (context, error, stackTrace) =>
                  _empty(screenWidth, size * 0.4),
            )
          : _empty(screenWidth, size * 0.4),
    ),
  );
}

Widget _heroFallback(double screenWidth) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF3A78E0), Color(0xFF1E54C4)],
      ),
    ),
    child: Center(
      child: Icon(
        Icons.groups_rounded,
        size: screenWidth * 0.16,
        color: const Color(0x66FFFFFF),
      ),
    ),
  );
}

/// Full-width poster banner with a dark scrim and the title overlaid.
Widget detailHero(String? poster, String title, double screenWidth) {
  final bool hasImage = poster != null && poster.startsWith('http');
  return ClipRRect(
    borderRadius: BorderRadius.circular(screenWidth * 0.045),
    child: SizedBox(
      height: screenWidth * 0.54,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (hasImage)
            Image.network(
              poster,
              fit: BoxFit.cover,
              cacheWidth: 800,
              loadingBuilder: (context, child, progress) => progress == null
                  ? child
                  : _heroFallback(screenWidth),
              errorBuilder: (context, error, stackTrace) =>
                  _heroFallback(screenWidth),
            )
          else
            _heroFallback(screenWidth),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00000000), Color(0xCC000000)],
                stops: [0.4, 1.0],
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.045,
            right: screenWidth * 0.045,
            bottom: screenWidth * 0.04,
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.056,
                fontWeight: FontWeight.w800,
                height: 1.25,
                shadows: const [
                  Shadow(blurRadius: 6, color: Color(0x99000000)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// A single white card that groups several [sectionBlock]s with dividers.
Widget sectionCard(double screenWidth, List<Widget> children) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(screenWidth * 0.045),
      boxShadow: const [
        BoxShadow(color: Color(0x0F000000), blurRadius: 10, offset: Offset(0, 3)),
      ],
    ),
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}

Widget sectionDivider() {
  return Container(height: 1, color: const Color(0xFFEFF1F4));
}

/// Small label + content block, used inside [sectionCard].
Widget sectionBlock(double screenWidth, String label, Widget content) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.033,
            fontWeight: FontWeight.w700,
            color: cardSub,
            letterSpacing: 0.2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 9),
          child: content,
        ),
      ],
    ),
  );
}

/// Borderless multiline input for use inside a [sectionCard] / [sectionBlock].
Widget detailEditField(
  TextEditingController controller,
  String hint,
  double screenWidth,
) {
  return TextField(
    controller: controller,
    minLines: 3,
    maxLines: 6,
    style: TextStyle(
      fontSize: screenWidth * 0.041,
      height: 1.4,
      color: cardInk,
    ),
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.zero,
      border: InputBorder.none,
      hintText: hint,
      hintStyle: TextStyle(color: cardSub, fontSize: screenWidth * 0.041),
    ),
  );
}

Widget sectionText(String value, double screenWidth) {
  final bool empty = value.trim().isEmpty;
  return Text(
    empty ? '등록된 내용이 없습니다.' : value,
    style: TextStyle(
      fontSize: screenWidth * 0.04,
      height: 1.5,
      color: empty ? cardSub : cardInk,
    ),
  );
}

Widget cardField(String label, String value, double screenWidth) {
  return Row(
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.w600,
          color: cardSub,
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            value.isEmpty ? '-' : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: screenWidth * 0.036,
              fontWeight: FontWeight.w600,
              color: cardInk,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget cardInfoRow(IconData icon, String text, double screenWidth) {
  return Row(
    children: [
      Icon(icon, size: screenWidth * 0.042, color: cardSub),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: screenWidth * 0.034, color: cardSub),
          ),
        ),
      ),
    ],
  );
}

Widget cardRoleChips(List<String> position, double screenWidth) {
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: position
        .take(4)
        .map(
          (roleName) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: cardChipBg,
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
