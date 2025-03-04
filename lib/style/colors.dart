import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  // Couleur de nos termes
  static Color bdColor = Color(0xFFe2e2ff);
  static Color mainColor = Color(0xFF000633);
  static Color accentColor = Color(0xFF0065FF);

  // Couleur de nos différents Cards*

static List<Color> cardsColor = [
  Colors.white,
  Colors.red.shade100,
  Colors.pink.shade100,
  Colors.orange.shade100,
  Colors.green.shade100,
  Colors.blue.shade100,
  Colors.blueGrey.shade100,
];


// Paramètres des style de text
static TextStyle mainTitle =
GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.bold);

static TextStyle mainContent =
  GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.normal);

  static TextStyle dateTitle =
  GoogleFonts.roboto(fontSize: 13.0, fontWeight: FontWeight.w500);

}