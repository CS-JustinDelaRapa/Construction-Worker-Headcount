// ignore_for_file: file_names

import 'package:engineering/model/itemModel.dart';
import 'package:flutter/material.dart';

class ElectricalAndPlumbingItems {
  static const electricalWorks =
      DrawerItem(title: 'Electrical Works', icon: Icons.home);
  static const plumbingWorks =
      DrawerItem(title: 'Plumbing Works', icon: Icons.home);

  static final List<DrawerItem> all = [
    electricalWorks,
    plumbingWorks,
  ];
  static const List<String> listElectricalWorks = [
    'Roughing',
    'Cable Pulling',
    'Fixtures'
  ];
  static const List<String> listPlumbingWorks = ['Works', 'Fixture'];
}
