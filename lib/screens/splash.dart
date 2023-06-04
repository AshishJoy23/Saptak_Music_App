// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:saptak_music_app/database/models/db_all_models.dart';
import 'package:saptak_music_app/screens/app.dart';



class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

final audioQuery = OnAudioQuery();
final box = AllSongsBox.getInstance();
List<SongModel> fetchedSongs=[];
List<SongModel> allSongs=[];

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    requestPermission();
    goToMyApp();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  
  }

  void requestPermission() async{
    //Permission.storage.request();
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {// check for permission
      await audioQuery.permissionsRequest();// if permission not given, request it
    
      fetchedSongs = await audioQuery.querySongs();// fetch from internal storage and store in list
      log('fetched');
      for(var element in fetchedSongs){
        if (element.fileExtension=='mp3') {
          allSongs.add(element);//filtering mp3 audios and adding to allSongs list
        }
      }

      for (var element in allSongs) {
        box.add(AllSongs(  //addings songs into allSongs box
          songname: element.title, 
          artist: element.artist, 
          duration: element.duration, 
          id: element.id, 
          songuri: element.uri));
      }
      // for (var element in allSongs) {
      //   mostlyPlayedBox.add(MostlyPlayed(
      //     songname: element.title, 
      //     songuri: element.uri, 
      //     duration: element.duration, 
      //     artist: element.artist, 
      //     count: 0, // adding songs to mostlyPlayedBox to initialise count as 0
      //     id: element.id));
      // }
    }
  }

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 1, 10),
      body: Center(
          child: Row(
            children: [
              SizedBox(
                width: width1*0.06,
              ),
              SizedBox(
                //color: Colors.amber,
                width: width1*0.8,
                child: Stack(children: [
                  const Icon(
                    Icons.music_note_rounded,
                    size: 158,
                    color: Color.fromARGB(255, 152, 248, 72),
                  ),
                  Positioned(
                      left: width1*0.25,
                      top: height1*0.05,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'aptak',
                            style: TextStyle(
                              fontSize: 70,
                              fontFamily: 'HappyMonkey',
                              color: Color.fromARGB(255, 152, 248, 72),
                            ),
                          ),
                          const Text(
                            'Welcome to the world of music',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                                wordSpacing: 2),
                          )
                        ],
                      )),
                ]),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> goToMyApp() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const MyMusicApp()),
    );
  }
}
   