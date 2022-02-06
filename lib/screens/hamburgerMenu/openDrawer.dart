import 'package:flutter/material.dart';

class OpenDrawerWidget extends StatelessWidget {
  final VoidCallback onClicked;
  const OpenDrawerWidget({ Key? key, required this.onClicked }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: onClicked,
    );
  }
}