import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:saptak_music_app/database/models/db_all_models.dart';
import 'package:saptak_music_app/screens/favorites/favorites_list.dart';
import 'package:saptak_music_app/screens/playlists/playlists.dart';
import 'package:saptak_music_app/screens/settings/settings.dart';
import 'home/home.dart';

class MyMusicApp extends StatefulWidget {
  const MyMusicApp({super.key});

  @override
  State<MyMusicApp> createState() => _MyMusicAppState();
}

class _MyMusicAppState extends State<MyMusicApp> {
  int _selectedIndex = 0;
  var _screens = [];
  int? currentIndex;
  int? totalLength;
  AllSongs? currentSong;
  

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _screens = [
    const ScreenHome(title: 'Saptak'),
    const ScreenFavorites(title: 'Favorites'),
    const ScreenPlaylists(title: 'Playlists'),
    const ScreenSettings(title: 'Settings'),
  ];
  }

  @override
  Widget build(BuildContext context) {
    final heightDsp = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavyBar(
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: const Icon(Icons.home_outlined),
              title: const Text('Home',style: TextStyle(fontSize: 15)),
              inactiveColor: Colors.white,
              activeColor: const Color.fromARGB(255, 152, 248, 72),),
          BottomNavyBarItem(
              icon: const Icon(Icons.favorite_outline),
              title: const Text('Favorites',style: TextStyle(fontSize: 15)),
              inactiveColor: Colors.white,
              activeColor: const Color.fromARGB(255, 152, 248, 72),),
          BottomNavyBarItem(
              icon: const Icon(Icons.playlist_add),
              title: const Text('Playlists',style: TextStyle(fontSize: 15)),
              inactiveColor: Colors.white,
              activeColor: const Color.fromARGB(255, 152, 248, 72),),
          BottomNavyBarItem(
              icon: const Icon(Icons.settings_outlined),
              title: const Text('Settings',style: TextStyle(fontSize: 15),),
              inactiveColor: Colors.white,
              activeColor: const Color.fromARGB(255, 152, 248, 72),),
        ],
        backgroundColor: const Color.fromARGB(255, 0, 1, 10),
        selectedIndex: _selectedIndex,
        showElevation: true,
        iconSize: 30,
        containerHeight: heightDsp*0.075,
        itemCornerRadius: 28,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  BottomNavyBarItem bottomNavigationItems(
      {required bottomNavIcon,
      required bottomNavLabel,
      required bottomNavActive}) {
    return BottomNavyBarItem(
      icon: Icon(bottomNavIcon),
      title: bottomNavLabel,
      activeColor: const Color.fromARGB(255, 152, 248, 72),
    );
  }

}
