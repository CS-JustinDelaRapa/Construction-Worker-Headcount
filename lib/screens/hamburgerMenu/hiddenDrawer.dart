// ignore_for_file: file_names, unused_import

import 'package:engineering/model/itemModel.dart';
import 'package:engineering/theme/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawerItems.dart';

class HiddenDrawer extends StatelessWidget {
  final ValueChanged<DrawerItem> onSelectedItem;

  const HiddenDrawer({Key? key, required this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Construction Worker Headcount',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25)),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Construction Application',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            buildDrawerItems(context),
          ],
        ),
      );

  Widget buildDrawerItems(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: DrawerItems.all
                .map((item) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.085,
                      child: ListTile(
                          title: Text(item.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          leading: Icon(item.icon),
                          onTap: () => onSelectedItem(item)),
                    ))
                .toList()),
      );
}
