import 'package:flutter/material.dart';

class PostDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Handle the tap
            },
          ),
        ],
      ),
    );
  }
}