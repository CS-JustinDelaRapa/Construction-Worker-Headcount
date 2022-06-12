// ignore_for_file: file_names

import 'package:engineering/model/defaulValueModel.dart';
import 'package:engineering/model/itemModel.dart';
import 'package:engineering/custom_icons_icons.dart';
import 'package:flutter/material.dart';

class BungalowArchitechturalItems {
  static const List<String> listFlooringWorks = [
    'EXT T&B',
    'T&B',
  ];
  static const List<String> listPlasteringWorks = ['Interior', 'Exterior'];
  static const List<String> listPaintingWorks = [
    'Interior Skim Coat',
    'Exterior Skim Coat',
    "Interior",
    "Exterior"
  ];
  static const List<String> listDoornWindowsWorks = [
    'Jamb',
    'Lockset ',
    'Doors',
    'Windows'
  ];
  static const List<String> listCeilingWorks = ['Steel Frame', 'Plywood'];
  static const List<String> listRoofingWorks = [
    'Trusses',
    'GI Sheets',
    'Gutter'
  ];

  static const List<DefaultValue> defValFlooringWorks = [
    DefaultValue(col_1: "Mosaic Tile", col_1_val: 7.0),
    DefaultValue(col_1: "Mosaic Tile", col_1_val: 7.0),
  ];

  static const List<DefaultValue> defValPlasteringWorks = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 10.0),
    DefaultValue(col_1: "DEFAULT", col_1_val: 8.0),
  ];

  static const List<DefaultValue> defValPaintingWorks = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 6.4),
    DefaultValue(col_1: "DEFAULT", col_1_val: 8.6),
    DefaultValue(col_1: "OBD", col_1_val: 12),
    DefaultValue(col_1: "Snowcem", col_1_val: 20.0),
  ];

  static const List<DefaultValue> defValDoorsAndWindowsWorks = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 3.52),
    DefaultValue(col_1: "DEFAULT", col_1_val: 10.24),
    DefaultValue(col_1: "DEFAULT", col_1_val: 21.6), // Doors
    DefaultValue(col_1: "DEFAULT", col_1_val: 12.8), // Windows
  ];

  static const List<DefaultValue> defValCeilingWorks = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 21.28),
    DefaultValue(col_1: "DEFAULT", col_1_val: 16.0),
  ];

  static const List<DefaultValue> defValRoofingngWorks = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 4.0),
    DefaultValue(col_1: "DEFAULT", col_1_val: 11.52),
    DefaultValue(col_1: "DEFAULT", col_1_val: 2.7),
  ];

  static const flooring =
      DrawerItem(title: 'Flooring', icon: CustomIcons.flooring);
  static const plastering =
      DrawerItem(title: 'Plastering', icon: CustomIcons.plastering);
  static const paintingWorks =
      DrawerItem(title: 'Painting Works', icon: CustomIcons.painting);
  static const doorsAndWindows =
      DrawerItem(title: 'Doors and Windows', icon: CustomIcons.doors);
  static const ceiling =
      DrawerItem(title: 'Ceiling', icon: CustomIcons.ceiling);
  static const roofingWorks =
      DrawerItem(title: 'Roofing Works', icon: CustomIcons.roofing);

  static final List<DrawerItem> all = [
    flooring,
    plastering,
    paintingWorks,
    doorsAndWindows,
    ceiling,
    roofingWorks
  ];
}
