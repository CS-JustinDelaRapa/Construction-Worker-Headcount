import 'package:engineering/model/itemModel.dart';
import 'package:flutter/material.dart';

class DrawerItems {
  static const home = DrawerItem(title: 'Home', icon: Icons.home);
  static const structural = DrawerItem(title: 'Structural', icon: Icons.home);
  static const architectural = DrawerItem(title: 'Architectural', icon: Icons.home);
  static const electricalAndPlumming = DrawerItem(title: 'Electrical & Plumbing', icon: Icons.home);
  static const rateOfWorkers = DrawerItem(title: 'Rate of Workers', icon: Icons.home);
  static const productivityRate = DrawerItem(title: 'Productivity Rate', icon: Icons.home);
  static const manPowerDistribution = DrawerItem(title: 'Manpower Distribution', icon: Icons.home);
  static const additionalManpower = DrawerItem(title: 'Additional Manpower', icon: Icons.home);

  static final List<DrawerItem> all = [
    home,
    structural,
    architectural,
    electricalAndPlumming,
    rateOfWorkers,
    productivityRate,
    manPowerDistribution,
    additionalManpower
  ];
}