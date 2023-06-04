// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:saptak_music_app/database/db_functions.dart';
import 'package:saptak_music_app/database/models/db_all_models.dart';
import 'package:saptak_music_app/screens/playlists/each_playlistsongs.dart';
import '../home/home.dart';

class ScreenPlaylists extends StatefulWidget {
  const ScreenPlaylists({required this.title, super.key});

  final String title;
  @override
  State<ScreenPlaylists> createState() => _ScreenPlaylistsState();
}

class _ScreenPlaylistsState extends State<ScreenPlaylists> {
  String selectedItem = 'Remove';
  final playlistController = TextEditingController();
  final playlistAppbarController = TextEditingController();
  late List<Playlists> allDbPlaylists;

  @override
  void initState() {
    allDbPlaylists = playlistsBox.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heightDsp = MediaQuery.of(context).size.height;
    final widthDsp = MediaQuery.of(context).size.height;
    allDbPlaylists = playlistsBox.values.toList();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Create New Playlist'),
                      content: GestureDetector(
                        child: TextField(
                          controller: playlistAppbarController,
                          cursorColor: Colors.black,
                          cursorHeight: 28,
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            prefixIcon: Icon(
                              Icons.playlist_add,
                              color: Colors.black,
                              size: 26,
                            ),
                            focusColor: Colors.black,
                            hintText: 'Enter the Name...',
                            hintStyle: TextStyle(
                                color: Colors.black54, fontFamily: 'Poppins'),
                            // filled: true,
                            // fillColor: Color.fromARGB(255, 14, 17, 42),
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              playlistAppbarController.clear();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: const Text('Cancel')),
                        ValueListenableBuilder<TextEditingValue>(
                          valueListenable: playlistAppbarController,
                          builder: (context, value, child) {
                            if (playlistAppbarController.text.isEmpty) {
                              return TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text('Please Enter a Name'),
                                        duration: Duration(milliseconds: 600),
                                      ),
                                    );
                                  },
                                  child: const Text('Create'));
                            } else {
                              return ElevatedButton(
                                  onPressed: (checkIfAlreadyExists(
                                          playlistAppbarController.text))
                                      ? () {
                                          playlistAppbarController.clear();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Playlist Already Exists'),
                                              duration:
                                                  Duration(milliseconds: 600),
                                            ),
                                          );
                                        }
                                      : () {
                                          playlistsBox.add(Playlists(
                                            playlistname:
                                                playlistAppbarController.text,
                                            playlistssongs: [],
                                          ));
                                          playlistAppbarController.clear();
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          Navigator.of(context).pop();
                                          setState(() {});
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'New Playlist Created'),
                                              duration:
                                                  Duration(milliseconds: 800),
                                            ),
                                          );
                                        },
                                  child: const Text('Create'));
                            }
                          },
                        ),
                      ],
                    );
                  });
              //setState(() {});
            },
            icon: const Icon(Icons.add_circle,
                size: 28, color: Color.fromARGB(255, 152, 248, 72)),
          ),
          SizedBox(
              width: widthDsp*0.02,
            )
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
      body: (playlistsBox.isEmpty)
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
          : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Row(
                    children: const [
                      Text(
                        'Your Playlists',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                                color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightDsp * 0.02,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allDbPlaylists.length,
                    itemBuilder: (context, index) {
                      allDbPlaylists = playlistsBox.values.toList();
                      final currentPlaylist = allDbPlaylists[index];  
                      return ListTile(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EachPlaylistSongs(
                                      playlist: currentPlaylist)));
                          setState(() {});
                        },
                        leading: (currentPlaylist.playlistssongs!.isEmpty)
                            ? Container(
                                width: widthDsp * 0.065,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/images/saptak_icon.png')),
                                ),
                                //child: Icon(Icons.abc),
                              )
                            : QueryArtworkWidget(
                                artworkFit: BoxFit.cover,
                                id: currentPlaylist.playlistssongs!.first.id!,
                                type: ArtworkType.AUDIO,
                                artworkQuality: FilterQuality.high,
                                size: 2000,
                                quality: 100,
                                artworkBorder: BorderRadius.circular(10),
                                nullArtworkWidget: Container(
                                  width: widthDsp * 0.065,
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
                        title: Text(
                          currentPlaylist.playlistname!,
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              color: Colors.white),
                        ),
                        subtitle: Text((currentPlaylist.playlistssongs!.length<=1)
                          ?'${currentPlaylist.playlistssongs!.length.toString()} Song'
                          :'${currentPlaylist.playlistssongs!.length.toString()} Songs',
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
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
                              value: "Delete",
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return AlertDialog(
                                            title: Text(
                                                'Delete ${currentPlaylist.playlistname} Playlist'),
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
                                                    allDbPlaylists
                                                        .removeAt(index);
                                                    playlistsBox
                                                        .deleteAt(index);
                                                    setState(() {});
                                                    Navigator.of(ctx).pop();
                                                    ScaffoldMessenger.of(ctx)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Deleted from Playlists'),
                                                        duration: Duration(
                                                            milliseconds: 600),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text('Delete'))
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text('Delete',
                                      style: TextStyle(fontSize: 14))),
                            ),
                            PopupMenuItem<String>(
                              value: "Rename",
                              child: TextButton(
                                  onPressed: () {
                                    playlistController.text = currentPlaylist.playlistname!;
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Rename the Playlist'),
                                            content: GestureDetector(
                                              child: TextField(
                                                controller: playlistController,
                                                cursorColor: Colors.black,
                                                cursorHeight: 28,
                                                onTap: () {
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  prefixIcon: Icon(
                                                    Icons.playlist_add,
                                                    color: Colors.black,
                                                    size: 26,
                                                  ),
                                                  focusColor: Colors.black,
                                                  hintText:
                                                      'Enter the New Name...',
                                                  hintStyle: TextStyle(
                                                      color: Colors.black54,
                                                      fontFamily: 'Poppins'),
                                                  // filled: true,
                                                  // fillColor: Color.fromARGB(255, 14, 17, 42),
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    playlistController.clear();
                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                  },
                                                  child: const Text('Cancel')),
                                              ValueListenableBuilder<
                                                  TextEditingValue>(
                                                valueListenable:
                                                    playlistController,
                                                builder:
                                                    (context, value, child) {
                                                  if (playlistController
                                                      .text.isEmpty) {
                                                    return TextButton(
                                                        onPressed: () {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                  'Please Enter a Name'),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      600),
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                            'Rename'));
                                                  } else {
                                                    return ElevatedButton(
                                                        onPressed:
                                                            (checkIfAlreadyExists(
                                                                    playlistController
                                                                        .text))
                                                                ? () {
                                                                    playlistController.clear();
                                                                    //playlistController.text = currentPlaylist.playlistname!;
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                        content:
                                                                            Text('Name Already Exists'),
                                                                        duration:
                                                                            Duration(milliseconds: 600),
                                                                      ),
                                                                    );
                                                                  }
                                                                : () {
                                                                    currentPlaylist
                                                                            .playlistname =
                                                                        playlistController
                                                                            .text;
                                                                    playlistsBox.putAt(index, currentPlaylist);
                                                                    playlistController
                                                                        .clear();
                                                                    setState(
                                                                        () {});
                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                        content:
                                                                            Text('Playlist Renamed'),
                                                                        duration:
                                                                            Duration(milliseconds: 800),
                                                                      ),
                                                                    );
                                                                  },
                                                        child: const Text(
                                                            'Rename'));
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text('Rename',
                                      style: TextStyle(fontSize: 14))),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ]),
              ),
          ),
    );
  }

  bool checkIfAlreadyExists(String name) {
    bool isAlreadyAdded = allDbPlaylists
        .where((element) => element.playlistname == name.trim())
        .isNotEmpty;
    return isAlreadyAdded;
  }
}
