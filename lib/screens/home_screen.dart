import 'package:flutter/material.dart';
import 'package:sidebar_bigeagle/sidebar_bigeagle.dart';
import 'package:wrotto_web/screens/calendar_screen.dart';
import 'package:wrotto_web/screens/entries_screen/entries_screen.dart';
import 'package:wrotto_web/screens/map_screens/map_screen.dart';
import 'package:wrotto_web/screens/medias_screen.dart';
import 'package:wrotto_web/screens/stats_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> pages = [];
  @override
  void initState() {
    super.initState();
    pages = [
      EntriesScreen(),
      CalendarScreen(),
      MapScreen(),
      MediasScreen(),
      StatsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(
              color: Colors.teal,
              appColor: Colors.white,
              accentColor: Colors.white,
              onHoverScale: 1.2,
              logo: Container(),
              children: [
                SideBarButtonFlat(title: "Entries", icon: Icons.edit),
                SideBarButtonFlat(
                    title: "Calendar", icon: Icons.calendar_today),
                SideBarButtonFlat(title: "Map", icon: Icons.map),
                SideBarButtonFlat(title: "Media", icon: Icons.perm_media),
                SideBarButtonFlat(title: "Stats", icon: Icons.graphic_eq),
              ],
              onChange: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              }),
          Expanded(
            child: pages[_selectedIndex],
          )
        ],
      ),
    );
  }
}
