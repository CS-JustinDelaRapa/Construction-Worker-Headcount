// ignore_for_file: file_names

import 'package:engineering/model/itemModel.dart';
import 'package:flutter/material.dart';

class BungalowStructuralItems {
  static const List<String> listEarthWorks = ['Excavation', 'Backfilling'];
  static const List<String> listFormWorks = [
    'Footings',
    'Column',
    'Beam',
    'Slab',
  ];
  static const List<String> listMasonryWorks = ['Exterior', 'Interior'];
  static const List<String> listReinforecedWorks = [
    'Footings',
    'Columns',
    'Beams',
    'Slabs'
  ];
  static const List<String> listSteelReinforecedWorks = [
    'Footings',
    'Column',
    'Slabs',
    'Beams',
    'Lintels',
    'Stirrups, spacers and links',
    'Walls',
    'Wall type',
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
