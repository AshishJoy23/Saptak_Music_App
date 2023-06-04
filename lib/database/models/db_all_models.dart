import 'package:hive/hive.dart';
part 'db_all_models.g.dart';


@HiveType(typeId: 0)
class AllSongs {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songuri;
  @HiveField(4)
  int? id;

  AllSongs({
    required this.songname,
    required this.artist,
    required this.duration,
    required this.id,
    required this.songuri,
  });
}

String boxname = 'allsongs';

// creating the instance of
class AllSongsBox {
  static Box<AllSongs>? _box; //creating the object
  static Box<AllSongs> getInstance() {
    //return the values into the list by using _box object.
    return _box ??= Hive.box(boxname);
  }
}


@HiveType(typeId: 1)
class RecentlyPlayed {
  @HiveField(0)
  String? songname;

  @HiveField(1)
  String? artist;

  @HiveField(2)
  int? duration;

  @HiveField(3)
  String? songuri;

  @HiveField(4)
  int? id;

  RecentlyPlayed(
      {required this.songname,
      required this.artist,
      required this.duration,
      required this.songuri,
      required this.id});
}

@HiveType(typeId: 2)

class MostlyPlayed {
  @HiveField(0)
  String songname;

  @HiveField(1)
  String? artist;

  @HiveField(2)
  int? duration;

  @HiveField(3)
  String? songuri;

  @HiveField(4)
  int count;

  @HiveField(5)
  int? id;

  MostlyPlayed(
      {required this.songname,
      required this.songuri,
      required this.duration,
      required this.artist,
      required this.count,
      required this.id});
}

@HiveType(typeId: 3)
class Favorites {
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songuri;
  @HiveField(4)
  int? id;

  Favorites(
      {required this.songname,
      required this.artist,
      required this.duration,
      required this.songuri,
      required this.id});
}

@HiveType(typeId: 4)

class Playlists {
  @HiveField(0)
  String? playlistname;
  @HiveField(1)
  List<AllSongs>? playlistssongs; 

  Playlists(
    {required this.playlistname, 
    required this.playlistssongs});
}

@HiveType(typeId: 5)
class RecentSearches {
  @HiveField(0)
  String? songname;

  @HiveField(1)
  String? artist;

  @HiveField(2)
  int? duration;

  @HiveField(3)
  String? songuri;

  @HiveField(4)
  int? id;

  RecentSearches(
      {required this.songname,
      required this.artist,
      required this.duration,
      required this.songuri,
      required this.id});
}
