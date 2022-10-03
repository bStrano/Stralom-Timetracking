// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stralom_timetracking/src/modules/Dashboard/views/HomeScreen.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/views/HomeScreen.dart';
import 'package:stralom_timetracking/src/modules/settings/views/SettingsScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Stralom Time Tracking',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          Locale('pt'),
        ],
        localeResolutionCallback: (
            locale,
            supportedLocales,
            ) {
          return locale;
        },
        theme: ThemeData(
          brightness: Brightness.light,
          // Define the default brightness and colors.

          primaryColor: Colors.teal[800],
          colorScheme: ColorScheme.fromSwatch().copyWith(
              brightness: Brightness.light,
              secondary: Colors.purpleAccent,
          ),
          toggleableActiveColor: Colors.purpleAccent,
          primarySwatch: Colors.purple,

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: GoogleFonts.montserratTextTheme(),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          // Define the default brightness and colors.
          primaryColor: Colors.teal[800],
          colorScheme: ColorScheme.fromSwatch().copyWith(
              brightness: Brightness.dark,
              secondary: Colors.purpleAccent,
          ),
          toggleableActiveColor: Colors.purpleAccent,
          primarySwatch: Colors.purple,

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: GoogleFonts.montserratTextTheme(),
        ),
        themeMode: ThemeMode.dark,

        home: DefaultTabController(
          length: 3,
          child: BottomTabNavigator(),
        ));
  }
}

class BottomTabNavigator extends StatefulWidget {
  BottomTabNavigator({Key? key}) : super(key: key);

  final List<Widget> options = <Widget>[
    const DashboardHomeScreen(),
    const TrackerHomeScreen(),
    const SettingsHomeScreen(),
  ];

  @override
  State<BottomTabNavigator> createState() => _BottomTabNavigator();
}

class _BottomTabNavigator extends State<BottomTabNavigator> {
  int _selectedIndex = 0;

  void _onSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.options.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:  const Icon(Icons.access_alarm),
            label: AppLocalizations.of(context)!.menuTimeTracker,
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard),
              label: AppLocalizations.of(context)!.menuDashboard
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.menuSettings
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: _onSelect,
      ),
    );
  }
}
