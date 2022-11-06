// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:stralom_timetracking/src/modules/Dashboard/views/HomeScreen.dart';
import 'package:stralom_timetracking/src/modules/Projects/providers/ProjectProvider.dart';
import 'package:stralom_timetracking/src/modules/Tags/providers/TagProvider.dart';
import 'package:stralom_timetracking/src/modules/TimeTracker/views/Home/HomeScreen.dart';
import 'package:stralom_timetracking/src/modules/settings/views/SettingsScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'src/modules/TimeTracker/providers/TimeTrackerProvider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => TimeTrackerProvider()),
    ChangeNotifierProvider(create: (ctx) => ProjectProvider()),
    ChangeNotifierProvider(create: (ctx) => TagProvider())
  ], child: const MyApp()));
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
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.deepPurple,
            onPrimary: Colors.white,
            // Colors that are not relevant to AppBar in LIGHT mode:
            primaryContainer: Colors.grey,
            secondary: Colors.purpleAccent,
            secondaryContainer: Colors.grey,
            onSecondary: Colors.grey,
            background: Colors.grey,
            onBackground: Colors.grey,
            surface: Colors.grey,
            onSurface: Colors.grey,
            error: Colors.grey,
            onError: Colors.grey,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            surface: Colors.deepPurple,
            onSurface: Colors.white,
            // Colors that are not relevant to AppBar in DARK mode:
            primary: Colors.grey,
            onPrimary: Colors.grey,
            primaryContainer: Colors.grey,
            secondary: Colors.purpleAccent,
            secondaryContainer: Colors.grey,
            onSecondary: Colors.grey,
            background: Colors.grey,
            onBackground: Colors.grey,
            error: Colors.grey,
            onError: Colors.grey,
          ),
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
    const TrackerHomeScreen(),
    const DashboardHomeScreen(),
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
            icon: const Icon(Icons.access_alarm),
            label: AppLocalizations.of(context)!.menuTimeTracker,
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard),
              label: AppLocalizations.of(context)!.menuDashboard),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.menuSettings),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: _onSelect,
      ),
    );
  }
}
