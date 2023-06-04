import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:saptak_music_app/database/db_functions.dart';
import 'package:saptak_music_app/database/models/db_all_models.dart';


// ignore: must_be_immutable
class AddToFavorites extends StatefulWidget {
  int index;
  AddToFavorites({required this.index, super.key});

  @override
  State<AddToFavorites> createState() => _AddToFavoritesState();
}

class _AddToFavoritesState extends State<AddToFavorites> {
  List<Favorites> favSongs = [];
  final box = AllSongsBox.getInstance();
  late List<AllSongs> allDbSongs;

  @override
  void initState() {
    allDbSongs=box.values.toList();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    favSongs = favSongsBox.values.toList();
    return favSongs.where((element) => element.id==allDbSongs[widget.index].id).isEmpty
    ?TextButton(onPressed: (){
      log(allDbSongs[widget.index].id.toString());
      favSongsBox.add(
        Favorites(
          songname: allDbSongs[widget.index].songname, 
          artist: allDbSongs[widget.index].artist, 
          duration: allDbSongs[widget.index].duration, 
          songuri: allDbSongs[widget.index].songuri, 
          id: allDbSongs[widget.index].id));
          Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added to Favorites'),
          duration: Duration(milliseconds: 600),),
        );
    }, 
    child: const Text('Add to Favorites',style: TextStyle(fontSize: 14),))
    :TextButton(
      onPressed: (){
        int currentIndex = favSongs.indexWhere((element) => 
        element.id==allDbSongs[widget.index].id);
        favSongsBox.deleteAt(currentIndex);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Removed from Favorites'),
          duration: Duration(milliseconds: 600),),
        );
      }, 
      child: const Text('Remove from Favourites',style: TextStyle(fontSize: 14)));
  }
}