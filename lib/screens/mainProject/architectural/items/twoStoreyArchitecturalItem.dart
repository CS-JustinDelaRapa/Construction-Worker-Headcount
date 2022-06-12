// ignore_for_file: file_names

import 'package:engineering/model/itemModel.dart';
import 'package:flutter/material.dart';

import '../../../../custom_icons_icons.dart';
import '../../../../model/defaulValueModel.dart';

class TwoStoreyArchitechturalItems {
  static const List<String> listFlooringWorks = [
    'EXT T&B',
    'T&B',
  ];
  static const List<String> listPlasteringWorks = [
    'Interior GF',
    'Interior SF',
    'Exterior GF',
    'Exterior SF',
  ];
  static const List<String> listPaintingWorks = [
    'Interior Skim Coat GF',
    'Interior Skim Coat SF',
    "Exterior Skim Coat GF",
    "Exterior Skim Coat SF",
    'Interior GF',
    'Interior SF',
    'Exterior GF',
    'Exterior SF',
  ];
  static const List<String> listDoornWindowsWorks = [
    'Lockset ',
    'Jamb',
    'Doors',
    'Windows'
  ];
  static const List<String> listCeilingWorks = [
    'Steel Frame GF',
    'Steel Frame SF',
    'Plywood GF',
    'Plywood SF',
  ];
  static const List<String> listRoofingWorks = [
    'Trusses',
    'GI Sheets',
    'Gutter'
  ];

  static const List<DefaultValue> defValFlooringWorks = [
    DefaultValue(col_1: "Mosaic Tile", col_1_val: 7.0), // EXT T&B Ground Floor
    DefaultValue(col_1: "Mosaic Tile", col_1_val: 7.0), //'T&B Second Floor'
  ];

  static const List<DefaultValue> defValPlasteringWorks = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 10.0), // Interior GF
    DefaultValue(col_1: "DEFAULT", col_1_val: 10.0), // Interior SF
    DefaultValue(col_1: "DEFAULT", col_1_val: 8.0), // Exterior GF
    DefaultValue(col_1: "DEFAULT", col_1_val: 8.0), // Exterior SF
  ];

  static const List<DefaultValue> defValPaintingWorks = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 6.4), // Interior Skim Coat GF
    DefaultValue(col_1: "DEFAULT", col_1_val: 6.4), // Interior Skim Coat SF
    DefaultValue(col_1: "DEFAULT", col_1_val: 8.6), // Exterior Skim Coat GF
    DefaultValue(col_1: "DEFAULT", col_1_val: 8.6), // Exterior Skim Coat SF
    DefaultValue(col_1: "OBD", col_1_val: 12), // Interior GF
    DefaultValue(col_1: "OBD", col_1_val: 12), // Interior SF
    DefaultValue(col_1: "Snowcem", col_1_val: 20.0), // Exterior GF
    DefaultValue(col_1: "Snowcem", col_1_val: 20.0), // Exterior SF
  ];

  static const List<DefaultValue> defValDoorsAndWindowsWorks = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 3.52), // Lockset
    DefaultValue(col_1: "DEFAULT", col_1_val: 10.4), // Jamb
    DefaultValue(col_1: "DEFAULT", col_1_val: 21.6), // Doors
    DefaultValue(col_1: "DEFAULT", col_1_val: 12.8), // Windows
  ];

  static const List<DefaultValue> defValCeilingWorks = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 21.28), //Steel Frame GF
    DefaultValue(col_1: "DEFAULT", col_1_val: 21.28), //Steel Frame SF
    DefaultValue(col_1: "DEFAULT", col_1_val: 16.0), //Plywood GF
    DefaultValue(col_1: "DEFAULT", col_1_val: 16.0), //Plywood SF
  ];

  static const List<DefaultValue> defValRoofingngWorks = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 11.52), //Trusses
    DefaultValue(col_1: "DEFAULT", col_1_val: 4.0), //GI Sheets
    DefaultValue(col_1: "DEFAULT", col_1_val: 2.78), //Gutter
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
