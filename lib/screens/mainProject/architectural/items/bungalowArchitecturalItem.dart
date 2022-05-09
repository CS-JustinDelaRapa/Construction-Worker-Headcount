// ignore_for_file: file_names

import 'package:engineering/model/itemModel.dart';
import 'package:engineering/custom_icons_icons.dart';
import 'package:flutter/material.dart';

class BungalowArchitechturalItems {
  static const List<String> listFlooringWorks = [
    'EXT T&B:',
    'T&B:',
  ];
  static const List<String> listPlasteringWorks = ['Interior', 'Exterior'];
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
