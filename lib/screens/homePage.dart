// ignore: file_names
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing"),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Header',
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Item 1'),
              selected: _selectedDestination == 0,
              onTap: () => selectDestination(0),
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Item 2'),
              selected: _selectedDestination == 1,
              onTap: () => selectDestination(1),
            ),
            ListTile(
              leading: const Icon(Icons.label),
              title: const Text('Item 3'),
              selected: _selectedDestination == 2,
              onTap: () => selectDestination(2),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Label',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Item A'),
              selected: _selectedDestination == 3,
              onTap: () => selectDestination(3),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Animate a bottom drawer
              },
            ),
            const Spacer(),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  // Widget hamburgerMenu() => const IconButton(
  //     alignment: Alignment.topLeft,
  //     onPressed: null,
  //     icon: Icon(Icons.ac_unit_outlined));
  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
