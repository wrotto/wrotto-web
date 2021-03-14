import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wrotto_web/providers/entries_provider.dart';
import 'package:wrotto_web/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => EntriesProvider.instance,
          ),
        ],
        child: Builder(
            builder: (context) => MaterialApp(
                  title: 'Wrotto',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: MyHomePage(title: 'Wrotto'),
                )));
  }
}
