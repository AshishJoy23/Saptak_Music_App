import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:saptak_music_app/database/db_functions.dart';
import 'package:saptak_music_app/database/models/db_all_models.dart';
import 'package:saptak_music_app/screens/favorites/add_to_fav.dart';
import 'package:saptak_music_app/screens/playlists/add_to_playlist.dart';
import 'package:saptak_music_app/widgets/mini_player.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

final TextEditingController searchController = TextEditingController();
final box = AllSongsBox.getInstance();
late List<AllSongs> allDbSongs;
AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
List<Audio> convertSAudios = [];
List<AllSongs> suggestionList = [];
List<RecentSearches> searchedList =
    recentSearchesBox.values.toList().reversed.toList();

class _ScreenSearchState extends State<ScreenSearch> {
  bool isSearched = false;
  @override
  void initState() {
    allDbSongs = box.values.toList();
    for (var element in searchedList) {
      convertSAudios.add(Audio.file(element.songuri.toString(),
          metas: Metas(
              artist: element.artist,
              title: element.songname,
              id: element.id.toString())));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heightScrn = MediaQuery.of(context).size.height;
    final widthScrn = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,size: 28,color: Colors.white,)),
          title: GestureDetector(
            child: TextField(
              cursorColor: Colors.white,
              cursorHeight: 28,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: (value) {
                filterList(value);
                // setState(() {
                //   isSearched = !isSearched;
                // });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: Colors.white,
                  size: 26,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                      convertSAudios.clear();
                      searchedList =
                          recentSearchesBox.values.toList().reversed.toList();
                      for (var element in searchedList) {
                        convertSAudios.add(Audio.file(
                            element.songuri.toString(),
                            metas: Metas(
                                artist: element.artist,
                                title: element.songname,
                                id: element.id.toString())));
                      }
                      FocusManager.instance.primaryFocus?.unfocus();
                      isSearched = false;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 26,
                    )),
                focusColor: Colors.white,
                hintText: 'Search Here.....',
                hintStyle:
                    const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                filled: true,
                fillColor: const Color.fromARGB(255, 14, 17, 42),
              ),
              controller: searchController,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: (isSearched)
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: suggestionList.length + 1,
                            itemBuilder: ((context, index) {
                              RecentSearches searchedSong;
                              return (index == suggestionList.length)
                                  ? SizedBox(
                                      height: heightScrn * 0.08,
                                    )
                                  : ListTile(
                                      onTap: () {
                                        searchedSong = RecentSearches(
                                            songname:
                                                suggestionList[index].songname,
                                            artist:
                                                suggestionList[index].artist,
                                            duration:
                                                suggestionList[index].duration,
                                            songuri:
                                                suggestionList[index].songuri,
                                            id: suggestionList[index].id);
                                        updateRecentSearches(searchedSong);
                                        searchedList.insert(0, searchedSong);
                                        audioPlayer.open(
                                          Playlist(
                                              audios: convertSAudios,
                                              startIndex: index),
                                          showNotification: true,
                                          headPhoneStrategy: HeadPhoneStrategy
                                              .pauseOnUnplugPlayOnPlug,
                                          loopMode: LoopMode.playlist,
                                        );
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        setState(() {});
                                        showBottomSheet(
                                            context: context,
                                            builder: (ctx) {
                                              return MiniPlayer(
                                                  index: allDbSongs.indexWhere(
                                                      (element) =>
                                                          element.id ==
                                                          suggestionList[index]
                                                              .id));
                                            });
                                      },
                                      leading: QueryArtworkWidget(
                                        artworkFit: BoxFit.cover,
                                        id: suggestionList[index].id!,
                                        type: ArtworkType.AUDIO,
                                        artworkQuality: FilterQuality.high,
                                        size: 2000,
                                        quality: 100,
                                        artworkBorder:
                                            BorderRadius.circular(10),
                                        nullArtworkWidget: Container(
                                          width: widthScrn * 0.134,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/images/saptak_icon.png')),
                                          ),
                                          //child: Icon(Icons.abc),
                                        ),
                                      ),
                                      title: Marquee(
                                          animationDuration: const Duration(
                                              milliseconds: 5500),
                                          directionMarguee:
                                              DirectionMarguee.oneDirection,
                                          pauseDuration: const Duration(
                                              milliseconds: 1000),
                                          child: Text(
                                            suggestionList[index].songname!,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          )),
                                      subtitle: suggestionList[index].artist ==
                                              '<unknown>'
                                          ? const Text(
                                              'Unknown Artist',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              suggestionList[index].artist!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white),
                                            ),
                                    );
                            })),
                      ),
                    ],
                  )
                : (recentSearchesBox.isEmpty)
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: heightScrn * 0.08),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/lottie_animation/empty_state.json',
                                width: widthScrn * 0.6,
                                height: heightScrn * 0.25,
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
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Recent Searches',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                color: Colors.white),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white60.withOpacity(0.1)),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Clear All Your Recent Searches'),
                                            content:
                                                const Text('Are You Sure?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: const Text('Cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    recentSearchesBox.clear();
                                                    searchedList.clear();
                                                    setState(() {});
                                                    Navigator.of(ctx).pop();
                                                    ScaffoldMessenger.of(ctx)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Cleared Your Searches'),
                                                        duration: Duration(
                                                            milliseconds: 600),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text('Clear'))
                                            ],
                                          );
                                        });
                                  },
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Clear All',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white60),
                                      ),
                                      Icon(
                                        Icons.clear_all,
                                        size: 30,
                                        color: Colors.white60,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: searchedList.length + 1,
                                itemBuilder: ((context, index) {
                                  return (index == searchedList.length)
                                      ? SizedBox(
                                          height: heightScrn * 0.08,
                                        )
                                      : ListTile(
                                          onTap: () {
                                            RecentlyPlayed recentlySong;
                                            MostlyPlayed mostlySong;
                                            RecentSearches currentSong = searchedList[index];
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
                                                  audios: convertSAudios,
                                                  startIndex: index),
                                              showNotification: true,
                                              headPhoneStrategy:
                                                  HeadPhoneStrategy
                                                      .pauseOnUnplugPlayOnPlug,
                                              loopMode: LoopMode.playlist,
                                            );
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            setState(() {});
                                            showBottomSheet(
                                                context: context,
                                                builder: (ctx) {
                                                  return MiniPlayer(
                                                      index:
                                                          allDbSongs.indexWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  searchedList[
                                                                          index]
                                                                      .id));
                                                });
                                          
                                          },
                                          leading: QueryArtworkWidget(
                                            artworkFit: BoxFit.cover,
                                            id: searchedList[index].id!,
                                            type: ArtworkType.AUDIO,
                                            artworkQuality: FilterQuality.high,
                                            size: 2000,
                                            quality: 100,
                                            artworkBorder:
                                                BorderRadius.circular(10),
                                            nullArtworkWidget: Container(
                                              width: widthScrn * 0.134,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        'assets/images/saptak_icon.png')),
                                              ),
                                              //child: Icon(Icons.abc),
                                            ),
                                          ),
                                          title: Marquee(
                                              animationDuration: const Duration(
                                                  milliseconds: 5500),
                                              directionMarguee:
                                                  DirectionMarguee.oneDirection,
                                              pauseDuration: const Duration(
                                                  milliseconds: 1000),
                                              child: Text(
                                                searchedList[index].songname!,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              )),
                                          subtitle: searchedList[index]
                                                      .artist ==
                                                  '<unknown>'
                                              ? const Text(
                                                  'Unknown Artist',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  searchedList[index].artist!,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white),
                                                ),
                                          trailing: PopupMenuButton<String>(
                                            color: Colors.grey,
                                            padding: const EdgeInsets.all(1.0),
                                            onSelected: (String value) {
                                              setState(() {
                                                //selectedItem = value;
                                              });
                                            },
                                            itemBuilder:
                                                (BuildContext context) =>
                                                    <PopupMenuEntry<String>>[
                                              PopupMenuItem<String>(
                                                value: "Favorites",
                                                child: AddToFavorites(
                                                    index: allDbSongs
                                                        .indexWhere((element) =>
                                                            element.id ==
                                                            searchedList[index]
                                                                .id)),
                                              ),
                                              PopupMenuItem<String>(
                                                value: "Playlists",
                                                child: AddToPlaylists(
                                                    songIndex: allDbSongs
                                                        .indexWhere((element) =>
                                                            element.id ==
                                                            searchedList[index]
                                                                .id)),
                                              ),
                                            ],
                                          ),
                                        );
                                })),
                          ],
                        ),
                      )));
  }

  filterList(String searchText) {
    isSearched = true;
    log(isSearched.toString());
    suggestionList = allDbSongs
        .where((element) =>
            element.songname!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    convertSAudios.clear();
    for (var item in suggestionList) {
      convertSAudios.add(Audio.file(item.songuri.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
    setState(() {});
  }
}
