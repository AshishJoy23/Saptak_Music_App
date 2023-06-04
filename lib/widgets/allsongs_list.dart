import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:saptak_music_app/database/db_functions.dart';
import 'package:saptak_music_app/database/models/db_all_models.dart';
import 'package:saptak_music_app/screens/favorites/add_to_fav.dart';
import 'package:saptak_music_app/widgets/mini_player.dart';
import '../Screens/playlists/add_to_playlist.dart';

class ScreenAllSongs extends StatefulWidget {
  const ScreenAllSongs({super.key});

  @override
  State<ScreenAllSongs> createState() => _ScreenAllSongsState();
}

class _ScreenAllSongsState extends State<ScreenAllSongs> {
  String selectedItem = "Favorites";
  final box = AllSongsBox.getInstance();
  late List<AllSongs> dbAllSongs;
  List<Audio> convertAudios = [];
  List<MostlyPlayed> mostlyDbSongs = mostlyPlayedBox.values.toList();
  @override
  void initState() {
    dbAllSongs = box.values.toList();

    for (var element in dbAllSongs) {
      convertAudios.add(Audio.file(element.songuri!,
          metas: Metas(
            title: element.songname,
            artist: element.artist,
            id: element.id.toString(),
          )));
    }
    setState(() {});
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final heightDsp = MediaQuery.of(context).size.height;
    final widthDsp = MediaQuery.of(context).size.width;
    return (dbAllSongs.isEmpty)
        ? Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: heightDsp*0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie_animation/empty_state.json',
                    width: widthDsp * 0.6,
                    height: heightDsp * 0.25,
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
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dbAllSongs.length+1,
            itemBuilder: (context, index) {
              //AllSongs currentSong = dbAllSongs[index];
              //MostlyPlayed mostlySong = mostlyDbSongs[index];
              RecentlyPlayed recentlySong;
              MostlyPlayed mostlySong;
              // RecentlyPlayed recentlySong = recentlyDbSongs[index];
              return (index==dbAllSongs.length)
                        ?SizedBox(
                          height: heightDsp*0.08,
                        )
                        :
              ListTile(
                onTap: () {
                  recentlySong = RecentlyPlayed(
                      songname: dbAllSongs[index].songname,
                      artist: dbAllSongs[index].artist,
                      duration: dbAllSongs[index].duration,
                      songuri: dbAllSongs[index].songuri,
                      id: dbAllSongs[index].id);
                  mostlySong = MostlyPlayed(
                    songname: dbAllSongs[index].songname!, 
                    songuri: dbAllSongs[index].songuri, 
                    duration: dbAllSongs[index].duration, 
                    artist: dbAllSongs[index].artist, 
                    count: 1, 
                    id: dbAllSongs[index].id);
                  updateRecentlyPlayed(recentlySong);
                  updateMostlyPlayed(mostlySong);
                  audioPlayer.open(
                      Playlist(audios: convertAudios, startIndex: index),
                      headPhoneStrategy:
                          HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                      loopMode: LoopMode.playlist,
                      showNotification: true);
                  setState(() {});
                  showBottomSheet(
                      context: context,
                      builder: (context) {
                        return MiniPlayer(index: index);
                      });
                },
                leading: QueryArtworkWidget(
                  artworkFit: BoxFit.cover,
                  id: dbAllSongs[index].id!,
                  type: ArtworkType.AUDIO,
                  artworkQuality: FilterQuality.high,
                  size: 2000,
                  quality: 100,
                  artworkBorder: BorderRadius.circular(10),
                  nullArtworkWidget: Container(
                    width: widthDsp * 0.134,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/saptak_icon.png')),
                    ),
                    //child: Icon(Icons.abc),
                  ),
                ),
                title: Marquee(
                    animationDuration: const Duration(milliseconds: 5500),
                    directionMarguee: DirectionMarguee.oneDirection,
                    pauseDuration: const Duration(milliseconds: 1000),
                    child: Text(
                      dbAllSongs[index].songname!,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )),
                subtitle: dbAllSongs[index].artist == '<unknown>'
                    ? const Text(
                        'Unknown Artist',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    : Text(
                        dbAllSongs[index].artist!,
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
                    setState(() {
                      selectedItem = value;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: "Favorites",
                      child: AddToFavorites(index: index),
                    ),
                    PopupMenuItem<String>(
                      value: "Playlists",
                      child: AddToPlaylists(songIndex: index),
                    ),
                  ],
                ),
              );
            },
          );
    //   },
    // );
  }
}
