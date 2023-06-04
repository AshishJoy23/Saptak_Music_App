import 'package:flutter/material.dart';
import 'package:saptak_music_app/database/db_functions.dart';
import 'package:saptak_music_app/database/models/db_all_models.dart';


// ignore: must_be_immutable
class AddFavFromNow extends StatefulWidget {
  int index;
  AddFavFromNow({required this.index, super.key});

  @override
  State<AddFavFromNow> createState() => _AddFavFromNowState();
}

class _AddFavFromNowState extends State<AddFavFromNow> {
  List<Favorites> favSongs = [];
  final box = AllSongsBox.getInstance();
  late List<AllSongs> allDbSongs;

  @override
  void initState() {
    allDbSongs = box.values.toList();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    favSongs = favSongsBox.values.toList();
    setState(() {});
    return favSongs
            .where((element) => element.id == allDbSongs[widget.index].id)
            .isEmpty
        ? IconButton(
            onPressed: () {
              favSongsBox.add(Favorites(
                  songname: allDbSongs[widget.index].songname,
                  artist: allDbSongs[widget.index].artist,
                  duration: allDbSongs[widget.index].duration,
                  songuri: allDbSongs[widget.index].songuri,
                  id: allDbSongs[widget.index].id));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to Favorites'),
                  duration: Duration(milliseconds: 600),
                ),
              );
               setState(() {});
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Color.fromARGB(255, 152, 248, 72),
              size: 35,
            ))
        : IconButton(
            onPressed: () {
              int index = favSongs.indexWhere(
                  (element) => element.id == allDbSongs[widget.index].id);
              favSongsBox.deleteAt(index);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from Favorites'),
                  duration: Duration(milliseconds: 600),
                ),
              );
              setState(() {});
            },
            icon: const Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 152, 248, 72),
              size: 35,
            )
          );
  }
}
