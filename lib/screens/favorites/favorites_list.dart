import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:saptak_music_app/database/db_functions.dart';
import 'package:saptak_music_app/screens/search_screen.dart';
import 'package:saptak_music_app/widgets/mini_player.dart';
import '../../database/models/db_all_models.dart';
import '../playlists/add_to_playlist.dart';
import 'package:lottie/lottie.dart';

class ScreenFavorites extends StatefulWidget {
  final String title;
  const ScreenFavorites({required this.title, super.key});

  @override
  State<ScreenFavorites> createState() => _ScreenFavoritesState();
}

class _ScreenFavoritesState extends State<ScreenFavorites> {
  late int currentIndex;
  final box = AllSongsBox.getInstance();
  late List<AllSongs> allDbSongs;
  List<Audio> convertFavSongs = [];
  List<Favorites> favDbSongs = favSongsBox.values.toList().reversed.toList();
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  void initState() {
    allDbSongs = box.values.toList();
    
    for (var element in favDbSongs) {
      convertFavSongs.add(Audio.file(element.songuri!,
          metas: Metas(
              artist: element.artist,
              title: element.songname,
              id: element.id.toString())));
    }
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    //favDbSongs = favSongsBox.values.toList().reversed.toList();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScreenSearch()));
            },
            icon: const Icon(Icons.search_sharp,
                size: 28, color: Color.fromARGB(255, 152, 248, 72)),
          ),
          SizedBox(
              width: width1 * 0.01,
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: const Text('Clear Your Favorites'),
                          content: const Text('Are You Sure?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('Cancel')),
                            ElevatedButton(
                                onPressed: () {
                                  favSongsBox.clear();
                                  favDbSongs.clear();
                                  setState(() {});
                                  Navigator.of(ctx).pop();
                                  ScaffoldMessenger.of(ctx).showSnackBar(
                                    const SnackBar(
                                      content: Text('Cleared Your Songs'),
                                      duration: Duration(milliseconds: 600),
                                    ),
                                  );
                                },
                                child: const Text('Clear'))
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.clear_all_sharp, size: 28)),
            SizedBox(
              width: width1 * 0.02,
            ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(left: 40.0, bottom: 8.0),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 152, 248, 72),
            ),
          ),
        ),
      ),
      body: (favDbSongs.isEmpty)
          ? Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: height1 * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie_animation/empty_state.json',
                      width: width1 * 0.6,
                      height: height1 * 0.25,
                    ),
                    const Text(
                      "You haven't added anything ! \nAdd What You Love..",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
              child: 
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: favDbSongs.length + 1,
                    itemBuilder: (context, index) {
                      if (index == favDbSongs.length) {
                        return SizedBox(
                          height: height1 * 0.08,
                        );
                      }
                      Favorites currentSong = favDbSongs[index];
                      return ListTile(
                        onTap: () {
                          RecentlyPlayed recentlySong;
                          MostlyPlayed mostlySong;
                          recentlySong = RecentlyPlayed(
                          songname: currentSong.songname,
                          artist: currentSong.artist,
                          duration: currentSong.duration,
                          songuri: currentSong.songuri,
                          id: currentSong.id);
                          mostlySong = MostlyPlayed(
                          songname: currentSong.songname!, 
                          songuri: currentSong.songuri, 
                          duration: currentSong.duration, 
                          artist: currentSong.artist, 
                          count: 1, 
                          id: currentSong.id);
                          updateRecentlyPlayed(recentlySong);
                          updateMostlyPlayed(mostlySong);
                          audioPlayer.open(
                              Playlist(
                                  audios: convertFavSongs, startIndex: index),
                              showNotification: true,
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                              loopMode: LoopMode.playlist);
                          setState(() {});
                          showBottomSheet(
                              context: context,
                              builder: (context) {
                                return MiniPlayer(index: allDbSongs.indexWhere((element) =>
                                      element.id == currentSong.id));
                              });
                        },
                        leading: QueryArtworkWidget(
                          artworkFit: BoxFit.cover,
                          id: currentSong.id!,
                          type: ArtworkType.AUDIO,
                          artworkQuality: FilterQuality.high,
                          size: 2000,
                          quality: 100,
                          artworkBorder: BorderRadius.circular(10),
                          nullArtworkWidget: Container(
                            width: width1 * 0.134,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/saptak_icon.png')),
                            ),
                            //child: Icon(Icons.abc),
                          ),
                        ),
                        title: Marquee(
                            animationDuration:
                                const Duration(milliseconds: 5500),
                            directionMarguee: DirectionMarguee.oneDirection,
                            pauseDuration: const Duration(milliseconds: 1000),
                            child: Text(
                              currentSong.songname!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                        subtitle: currentSong.artist == '<unknown>'
                            ? const Text(
                                'Unknown Artist',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )
                            : Text(
                                currentSong.artist!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                        trailing: PopupMenuButton<String>(
                          color: Colors.grey,
                          padding: const EdgeInsets.all(1.0),
                          onSelected: (String value) {
                            // setState(() {
                            //   var _selectedItem = value;
                            // });
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: "Favorites",
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Remove from Favorites'),
                                            content:
                                                const Text('Are You Sure?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: const Text('Cancel')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    convertFavSongs
                                                        .removeAt(index);
                                                    favDbSongs.removeAt(index);
                                                    favSongsBox.deleteAt(index);
                                                    setState(() {});
                                                    Navigator.of(ctx).pop();
                                                    ScaffoldMessenger.of(ctx)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Removed from Favorites'),
                                                        duration: Duration(
                                                            milliseconds: 600),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text('Remove'))
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text('Remove from Favorites',
                                      style: TextStyle(fontSize: 14))),
                            ),
                            PopupMenuItem<String>(
                              value: "Playlists",
                              child: AddToPlaylists(
                                  songIndex: allDbSongs.indexWhere((element) =>
                                      element.id == currentSong.id)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            ),
    );
  }
}
