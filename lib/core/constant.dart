import 'package:flutter/material.dart';

const Color appPrimaryColor = Color(0xFF3182F6);
const Color cardColor = Color(0xFFFDFDFD);
const Color posterColor = Color(0xFFE3E5E9);

const Color appHeaderColor = Color(0xFF1E4FB5);

const LinearGradient appPrimaryGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF3A78E0), Color(0xFF2A66D6)],
);

TextStyle sectionTitleFont = const TextStyle(
  fontFamily: 'NotoSansKR',
  fontSize: 24.0,
  fontWeight: FontWeight.w700,
);
TextStyle subTitleFont = const TextStyle(
  fontFamily: 'NotoSansKR',
  fontSize: 18.0,
  fontWeight: FontWeight.w700,
);
TextStyle tableCellFont = const TextStyle(fontFamily: 'NotoSansKR', fontSize: 13.0);
