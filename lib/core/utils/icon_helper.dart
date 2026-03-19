import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconHelper {
  static FaIconData getIcon(String name) {
    switch (name) {
      case 'mobileScreen': return FontAwesomeIcons.mobileScreen;
      case 'clockRotateLeft': return FontAwesomeIcons.clockRotateLeft;
      case 'database': return FontAwesomeIcons.database;
      case 'layerGroup': return FontAwesomeIcons.layerGroup;
      case 'mobileScreenButton': return FontAwesomeIcons.mobileScreenButton;
      case 'server': return FontAwesomeIcons.server;
      case 'palette': return FontAwesomeIcons.palette;
      case 'bolt': return FontAwesomeIcons.bolt;
      case 'flutter': return FontAwesomeIcons.flutter;
      case 'code': return FontAwesomeIcons.code;
      case 'atom': return FontAwesomeIcons.atom;
      case 'link': return FontAwesomeIcons.link;
      case 'github': return FontAwesomeIcons.github;
      case 'store': return FontAwesomeIcons.store;
      case 'brain': return FontAwesomeIcons.brain;
      case 'checkDouble': return FontAwesomeIcons.checkDouble;
      case 'gaugeHigh': return FontAwesomeIcons.gaugeHigh;
      case 'mobileButton': return FontAwesomeIcons.mobileButton;
      case 'laptopCode': return FontAwesomeIcons.laptopCode;
      default: return FontAwesomeIcons.circle;
    }
  }
}
