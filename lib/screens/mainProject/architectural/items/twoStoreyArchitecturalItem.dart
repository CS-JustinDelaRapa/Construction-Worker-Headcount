// ignore_for_file: file_names

import 'package:engineering/model/itemModel.dart';
import 'package:flutter/material.dart';

class TwoStoreyArchitechturalItems {
  static const List<String> listFlooringWorks = [
    'EXT T&B Ground Floor',
    'EXT T&B Second Floor',
    'T&B Ground Floor',
    'T&B Second Floor',
  ];
  static const List<String> listPlasteringWorks = [
    'Interior GF',
    'Interior SF',
    'Exterior GF',
    'Exterior SF',
  ];
  static const List<String> listPaintingWorks = [
    'Interior skim coat GF',
    'Interior skim coat SF',
    "Exterior skim coat GF",
    "Exterior skim coat SF",
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
    'Trusses ',
    'GI Sheets',
    'Gutter'
  ];

  static const flooring = DrawerItem(title: 'Flooring', icon: Icons.home);
  static const plastering = DrawerItem(title: 'Plastering', icon: Icons.home);
  static const paintingWorks =
      DrawerItem(title: 'Painting Works', icon: Icons.home);
  static const doorsAndWindows =
      DrawerItem(title: 'Doors and Windows', icon: Icons.home);
  static const ceiling = DrawerItem(title: 'Ceiling', icon: Icons.home);
  static const roofingWorks =
      DrawerItem(title: 'Roofing Works', icon: Icons.home);

  static final List<DrawerItem> all = [
    flooring,
    plastering,
    paintingWorks,
    doorsAndWindows,
    ceiling,
    roofingWorks
  ];
}
