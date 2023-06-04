import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:saptak_music_app/database/db_functions.dart';
import 'package:saptak_music_app/database/models/db_all_models.dart';
import 'package:saptak_music_app/screens/playlists/create_playlist.dart';

class AddToPlaylists extends StatefulWidget {
  int songIndex;
  AddToPlaylists({super.key, required this.songIndex});

  @override
  State<AddToPlaylists> createState() => _AddToPlaylistsState();
}

class _AddToPlaylistsState extends State<AddToPlaylists> {
  List<Playlists> allDbPlaylists = playlistsBox.values.toList();
  final box = AllSongsBox.getInstance();
  late List<AllSongs> allDbSongs;

  @override
  void initState() {
    allDbSongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widthDsp = MediaQuery.of(context).size.height;
    return TextButton(
        onPressed: (playlistsBox.isEmpty)
            ? () {
                Navigator.pop(context);
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CreatePlaylist(currentIndex: widget.songIndex);
                    });
              }
            : () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // set this to true
                  builder: (context) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.3,
                      maxChildSize: 0.3,
                      minChildSize: 0.2,
                      builder: (context, controller) {
                        return Container(
                          color: const Color.fromARGB(255, 14, 17, 42),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                CreatePlaylist(currentIndex: widget.songIndex),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: allDbPlaylists.length,
                                    controller: controller, // set this too
                                    itemBuilder: (context, index) => ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        List<AllSongs> eachPlaylistSongs =
                                            allDbPlaylists[index]
                                                .playlistssongs!
                                                .toList();
                                        bool isAlreadyAdded =
                                            eachPlaylistSongs.any((element) =>
                                                element.id ==
                                                allDbSongs[widget.songIndex]
                                                    .id);

                                        if (!isAlreadyAdded) {
                                          eachPlaylistSongs.add(AllSongs(
                                              songname:
                                                  allDbSongs[widget.songIndex]
                                                      .songname,
                                              artist:
                                                  allDbSongs[widget.songIndex]
                                                      .artist,
                                              duration:
                                                  allDbSongs[widget.songIndex]
                                                      .duration,
                                              id: allDbSongs[widget.songIndex]
                                                  .id,
                                              songuri:
                                                  allDbSongs[widget.songIndex]
                                                      .songuri));
                                          playlistsBox.putAt(
                                              index,
                                              Playlists(
                                                  playlistname:
                                                      allDbPlaylists[index]
                                                          .playlistname,
                                                  playlistssongs:
                                                      eachPlaylistSongs));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Song Added to ${allDbPlaylists[index].playlistname}'),
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Song Already Exist in ${allDbPlaylists[index].playlistname}'),
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                            ),
                                          );
                                        }
                                      },
                                      leading: (allDbPlaylists[index]
                                              .playlistssongs!
                                              .isEmpty)
                                          ? Container(
                                              width: widthDsp * 0.065,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        'assets/images/saptak_icon.png')),
                                              ),
                                              //child: Icon(Icons.abc),
                                            )
                                          : QueryArtworkWidget(
                                              artworkFit: BoxFit.cover,
                                              id: allDbPlaylists[index]
                                                  .playlistssongs!
                                                  .first
                                                  .id!,
                                              type: ArtworkType.AUDIO,
                                              artworkQuality:
                                                  FilterQuality.high,
                                              size: 2000,
                                              quality: 100,
                                              artworkBorder:
                                                  BorderRadius.circular(10),
                                              nullArtworkWidget: Container(
                                                width: widthDsp * 0.065,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          'assets/images/saptak_icon.png')),
                                                ),
                                                //child: Icon(Icons.abc),
                                              ),
                                            ),
                                      title: Text(
                                        allDbPlaylists[index].playlistname!,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        (allDbPlaylists[index]
                                                    .playlistssongs!
                                                    .length <=
                                                1)
                                            ? '${allDbPlaylists[index].playlistssongs!.length.toString()} Song'
                                            : '${allDbPlaylists[index].playlistssongs!.length.toString()} Songs',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            color: Colors.white),
                                      ),
                                      trailing: const Icon(Icons.add_circle,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
        child: const Text("Add to Playlists", style: TextStyle(fontSize: 14)));
  }
}
