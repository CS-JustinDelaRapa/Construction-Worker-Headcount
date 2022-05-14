// ignore_for_file: file_names

import 'package:engineering/model/defaulValueModel.dart';
import 'package:engineering/model/itemModel.dart';
import 'package:engineering/custom_icons_icons.dart';
import 'package:flutter/material.dart';

class BungalowStructuralItems {
  static const List<String> listEarthWorks = ['Excavation', 'Backfilling'];
  static const List<String> listFormWorks = [
    'Footings',
    'Column',
    'Beam',
    'Slab',
  ];
  static const List<String> listMasonryWorks = ['Interior','Exterior'];
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

  static const List<DefaultValue> defValEarthworks = [
    DefaultValue(col_1: "Soft Soil", col_1_val: 3.0),
    DefaultValue(col_1: "DEFAULT", col_1_val: 2.0),
  ];

  static const List<DefaultValue> defValFormworks = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 4.0),
    DefaultValue(col_1: "DEFAULT", col_1_val: 7.7),
    DefaultValue(col_1: "DEFAULT", col_1_val: 4.0),
    DefaultValue(col_1: "DEFAULT", col_1_val: 3.3),
    DefaultValue(col_1: "DEFAULT", col_1_val: 4.3),
  ];  

  static const List<DefaultValue> defValMasonry = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 0.0),
    DefaultValue(col_1: "8", col_1_val: 8.5),
  ];

  static const List<DefaultValue> defValRCC = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 1.5),
    DefaultValue(col_1: "DEFAULT", col_1_val: 1.0),
    DefaultValue(col_1: "DEFAULT", col_1_val: 1.0),
    DefaultValue(col_1: "DEFAULT", col_1_val: 2.0),
  ];

  static const List<DefaultValue> defValSRW = [
    DefaultValue(col_1: "DEFAULT", col_1_val: 190),
    DefaultValue(col_1: "DEFAULT", col_1_val: 200),
    DefaultValue(col_1: "DEFAULT", col_1_val: 173),
    DefaultValue(col_1: "DEFAULT", col_1_val: 175),
    DefaultValue(col_1: "DEFAULT", col_1_val: 150),
    DefaultValue(col_1: "DEFAULT", col_1_val: 100),
    DefaultValue(col_1: "DEFAULT", col_1_val: 200),
    DefaultValue(col_1: "DEFAULT", col_1_val: 0),    
  ];

  static const earthWorks =
      DrawerItem(title: 'Earthworks', icon: Icons.landscape);
  static const formWorks =
      DrawerItem(title: 'Formworks', icon: Icons.house_siding_outlined);
  static const masonryWorks =
      DrawerItem(title: 'Masonry Works', icon: Icons.construction_rounded);
  static const reiforecedCementConcrete = DrawerItem(
      title: 'Reinforced Cement Works', icon: CustomIcons.cement_works);
  static const steelReinforcedmentWork = DrawerItem(
      title: 'Steel Reinforcement Works', icon: Icons.precision_manufacturing);

  static final List<DrawerItem> all = [
    earthWorks,
    formWorks,
    masonryWorks,
    reiforecedCementConcrete,
    steelReinforcedmentWork
  ];
}
