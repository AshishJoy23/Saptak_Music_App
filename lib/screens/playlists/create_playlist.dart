import 'package:flutter/material.dart';
import 'package:saptak_music_app/database/db_functions.dart';
import 'package:saptak_music_app/database/models/db_all_models.dart';



class CreatePlaylist extends StatefulWidget {
  int currentIndex;
  CreatePlaylist({super.key,required this.currentIndex});

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  final TextEditingController playlistController = TextEditingController();
  final box = AllSongsBox.getInstance();
  late List<AllSongs> allDbSongs;

  @override
  void initState() {
    allDbSongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: const Text('Create New Playlist'),
                  content: GestureDetector(
                child: TextField(
                  controller: playlistController,
                  cursorColor: Colors.black,
                  cursorHeight: 28,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChanged: (value) {
                    
                  },
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
                    hintStyle:
                        TextStyle(color: Colors.black54, fontFamily: 'Poppins'),
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
                          Navigator.of(ctx).pop();
                          playlistController.clear();
                        },
                        child: const Text('Cancel')),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: playlistController,
                      builder: (context, value, child) {
                        if (playlistController.text.isEmpty) {
                          return TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('Please Enter a Name'),
                                duration: Duration(milliseconds: 600),
                              ),
                            );
                          },
                          child: const Text('Create')
                        );
                        } else {
                          return ElevatedButton(
                          onPressed: (checkIfAlreadyExists(playlistController.text)) 
                          ? (){
                            playlistController.clear();
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('Playlist Already Exists'),
                                duration: Duration(milliseconds: 600),
                              ),
                            );
                          }
                          :() {
                            playlistsBox.add(
                              Playlists(
                                playlistname: playlistController.text, 
                                playlistssongs: [AllSongs(
                                  songname: allDbSongs[widget.currentIndex].songname, 
                                  artist: allDbSongs[widget.currentIndex].artist, 
                                  duration: allDbSongs[widget.currentIndex].duration, 
                                  id: allDbSongs[widget.currentIndex].id, 
                                  songuri: allDbSongs[widget.currentIndex].songuri)
                                ],
                              ));
                              playlistController.clear();
                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('New Playlist Created and the Song is Added.'),
                                duration: Duration(milliseconds: 800),
                              ),
                            );
                          },
                          child: const Text('Create')
                        );
                       }
                        
                      },
                    ),
                  ],
                );
              });
        },
        style: const ButtonStyle(),
        icon: const Icon(Icons.playlist_add),
        label:
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10.0
                ),
              child: Text('Create New Playlist', style: TextStyle(fontSize: 18)),
            ));
  }

  bool checkIfAlreadyExists(String name){
    List<Playlists> allDbPlaylists = playlistsBox.values.toList();
    bool isAlreadyAdded = 
     allDbPlaylists.where((element) => element.playlistname==name.trim()).isNotEmpty;
     return isAlreadyAdded;
  }
}
