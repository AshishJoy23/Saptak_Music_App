import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:saptak_music_app/database/db_functions.dart';
import 'package:saptak_music_app/database/models/db_all_models.dart';
import 'package:saptak_music_app/screens/splash.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(AllSongsAdapter());
  await Hive.openBox<AllSongs>(boxname);
  runApp(const MyApp());

  Hive.registerAdapter(RecentlyPlayedAdapter());
  openRecentlyPlayedDb();

  Hive.registerAdapter(MostlyPlayedAdapter());
  openMostlyPlayedDb();

  Hive.registerAdapter(FavoritesAdapter());
  openFavoriteSongsDb();

  Hive.registerAdapter(PlaylistsAdapter());
  openPlaylistsDb();

  Hive.registerAdapter(RecentSearchesAdapter());
  openRecentSearchesDb();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saptak',
      theme: ThemeData(
        primarySwatch: const Color(0xFF00010A).toMaterialColor(),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color.fromARGB(255, 0,3,34),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color.fromARGB(255, 152, 248, 72)),
          // shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))),
        ),
      ),
      home: const ScreenSplash(),
    );
  }
}
