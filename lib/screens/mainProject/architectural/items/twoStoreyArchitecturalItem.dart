// ignore_for_file: file_names

import 'package:engineering/model/itemModel.dart';
import 'package:flutter/material.dart';

import '../../../../custom_icons_icons.dart';

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
    'Trusses ',
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
