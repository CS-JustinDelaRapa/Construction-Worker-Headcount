// ignore_for_file: file_names

import 'package:engineering/model/itemModel.dart';
import 'package:flutter/material.dart';

import '../../custom_icons_icons.dart';

class DrawerItems {
  static const home = DrawerItem(title: 'Home', icon: Icons.home);
  static const structural =
      DrawerItem(title: 'Structural', icon: CustomIcons.structural);
  static const architectural =
      DrawerItem(title: 'Architectural', icon: CustomIcons.architectural);
  static const electricalAndPlumming =
      DrawerItem(title: 'Electrical & Plumbing', icon: CustomIcons.eandp);
  static const rateOfWorkers =
      DrawerItem(title: 'Rate of Workers', icon: CustomIcons.rateofworkers);
  static const productivityRate = DrawerItem(
      title: 'Productivity Rate', icon: CustomIcons.productivityrate);
  static const manPowerDistribution = DrawerItem(
      title: 'Manpower Distribution', icon: CustomIcons.manpowerdistribution);
  static const additionalManpower = DrawerItem(
      title: 'Additional Manpower', icon: CustomIcons.additionalmanp);
  static const dateSchedule =
      DrawerItem(title: 'Construction Schedule', icon: Icons.calendar_today);

  static final List<DrawerItem> all = [
    home,
    structural,
    architectural,
    electricalAndPlumming,
    rateOfWorkers,
    productivityRate,
    manPowerDistribution,
    dateSchedule,
    additionalManpower
  ];
}
