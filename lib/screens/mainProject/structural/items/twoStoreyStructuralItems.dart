// ignore_for_file: file_names

import 'package:engineering/model/itemModel.dart';
import 'package:flutter/material.dart';

class TwoStoreyStructuralItems {
  static const List<String> listEarthWorks = ['Excavation', 'Backfilling'];
  static const List<String> listFormWorks = [
    'Footings',
    'Column Ground Floor',
    'Column Second Floor',
    'Beam FB',
    'Beam RB',
    'Slab GF',
    'Slab SF',
    'Staircase'
  ];
  static const List<String> listMasonryWorks = [
    'Exterior GF',
    'Exterior SF',
    'Interior GF',
    'Interior SF',
  ];
  static const List<String> listReinforecedWorks = [
    'Footings',
    'Columns GF',
    'Columns SF',
    'Beams FB',
    'Beams RB',
    'Slabs GF',
    'Slabs SF',
    'Staircase',
  ];
  static const List<String> listSteelReinforecedWorks = [
    'Footings',
    'Columns GF',
    'Columns SF',
    'Slabs GF',
    'Slabs SF',
    'Beams FB',
    'Beams SB',
    'Lintels',
    'STIRRUPS, SPACERS AND LINKS',
    'Staircase',
    'Walls GF',
    'Walls SF',
  ];

  static const earthWorks = DrawerItem(title: 'Earthworks', icon: Icons.landscape);
  static const formWorks = DrawerItem(title: 'Formworks', icon: Icons.house_siding_outlined);
  static const masonryWorks =
      DrawerItem(title: 'Masonry Works', icon: Icons.construction_rounded);
  static const reiforecedCementConcrete =
      DrawerItem(title: 'Reinforced Cement Works', icon: Icons.home);
  static const steelReinforcedmentWork =
      DrawerItem(title: 'Steel Reinforcement Works', icon: Icons.precision_manufacturing);

  static final List<DrawerItem> all = [
    earthWorks,
    formWorks,
    masonryWorks,
    reiforecedCementConcrete,
    steelReinforcedmentWork
  ];
}
