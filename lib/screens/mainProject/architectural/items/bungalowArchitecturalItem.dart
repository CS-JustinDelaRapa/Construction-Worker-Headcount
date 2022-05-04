// ignore_for_file: file_names

import 'package:engineering/model/itemModel.dart';
import 'package:flutter/material.dart';

class BungalowArchitechturalItems {
  static const List<String> listFlooringWorks = [
    'EXT T&B:',
    'T&B:',
  ];
  static const List<String> listPlasteringWorks = ['Inferior', 'Exterior'];
  static const List<String> listPaintingWorks = [
    'Interior Skim Coat',
    'Exterior Skim Coat',
    "Interior",
    "Exterior"
  ];
  static const List<String> listDoornWindowsWorks = [
    'Lockset ',
    'Jamb',
    'Doors',
    'Windows'
  ];
  static const List<String> listCeilingWorks = ['Steel Frame', 'Plywood'];
  static const List<String> listRoofingWorks = [
    'Trusses',
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
