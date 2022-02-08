import 'package:engineering/model/itemModel.dart';
import 'package:flutter/material.dart';

class StructuralItems {
    static const earthWorks = DrawerItem(title: 'Earthworks', icon: Icons.home);
    static const formWorks = DrawerItem(title: 'Formworks', icon: Icons.home);
    static const masonryWorks = DrawerItem(title: 'Masonry Works', icon: Icons.home);
    static const reiforecedCementConcrete = DrawerItem(title: 'Reinforced Cemenet Works', icon: Icons.home);
    static const steelReinforcedmentWork = DrawerItem(title: 'Steel Reinforemcent Works', icon: Icons.home);

    static final List<DrawerItem> all = [
      earthWorks,
      formWorks,
      masonryWorks,
      reiforecedCementConcrete,
      steelReinforcedmentWork
    ];
}