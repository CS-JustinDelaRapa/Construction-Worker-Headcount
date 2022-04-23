// ignore_for_file: file_names

import 'package:engineering/model/itemModel.dart';
import 'package:flutter/material.dart';

class StructuralItems {
  static const List<String> listEarthWorks = ['Excavation', 'Backfilling'];
  static const List<String> listFormWorks = ['Column', 'Beam', 'Slab'];
  static const List<String> listMasonryWorks = ['Exterior', 'Interior'];
  static const List<String> listReinforecedWorks = [
    'Footing',
    'Columns',
    'Beam',
    'Slab'
  ];
  static const List<String> listSteelReinforecedWorks = [
    'Footing',
    'Column',
    'Beam'
  ];

  static const earthWorks = DrawerItem(title: 'Earthworks', icon: Icons.home);
  static const formWorks = DrawerItem(title: 'Formworks', icon: Icons.home);
  static const masonryWorks =
      DrawerItem(title: 'Masonry Works', icon: Icons.home);
  static const reiforecedCementConcrete =
      DrawerItem(title: 'Reinforced Cement Works', icon: Icons.home);
  static const steelReinforcedmentWork =
      DrawerItem(title: 'Steel Reinforcement Works', icon: Icons.home);

  static final List<DrawerItem> all = [
    earthWorks,
    formWorks,
    masonryWorks,
    reiforecedCementConcrete,
    steelReinforcedmentWork
  ];
}
