import 'package:hive/hive.dart';
import 'models/db_all_models.dart';


late Box<RecentlyPlayed> recentlyPlayedBox;
openRecentlyPlayedDb() async {
  recentlyPlayedBox = await Hive.openBox('recentlyplayed');
}

late Box<MostlyPlayed> mostlyPlayedBox;
openMostlyPlayedDb() async {
  mostlyPlayedBox = await Hive.openBox('mostlyplayed');
}

late Box<Favorites> favSongsBox;
openFavoriteSongsDb() async {
  favSongsBox = await Hive.openBox('favoritesongs');
}

late Box<Playlists> playlistsBox;
openPlaylistsDb() async {
  playlistsBox = await Hive.openBox('playlists');
}

late Box<RecentSearches> recentSearchesBox;
openRecentSearchesDb() async {
  recentSearchesBox = await Hive.openBox('recentsearches');
}

updateRecentlyPlayed(RecentlyPlayed song){
  List<RecentlyPlayed> recentList = recentlyPlayedBox.values.toList();
  bool isNotPresent = recentList.where((element)
  {
    //check whether the current song is in the recently played
    //if not then isNotPresent becomes true otherwise false
    return element.songname == song.songname;
  }).isEmpty;
  if (isNotPresent == true) {
    recentlyPlayedBox.add(song);//if it is not present then add it
  }else{
    int indexRecent = recentList.indexWhere((element) => 
    element.songname==song.songname);  //if it is present find its index
    recentlyPlayedBox.deleteAt(indexRecent);  //delete the song at that index 
    recentlyPlayedBox.add(song); // add again the song to the recentlyPlayedBox
  }
}

updateMostlyPlayed(MostlyPlayed song){
  List<MostlyPlayed> mostlyList = mostlyPlayedBox.values.toList();
  bool isNotPresent = mostlyList.where((element)
  {
    //check whether the current song is in the recently played
    //if not then isNotPresent becomes true otherwise false
    return element.songname == song.songname;
  }).isEmpty;
  if (isNotPresent == true) {
    mostlyPlayedBox.add(song);//if it is not present then add it
  }else{
    int indexRecent = mostlyList.indexWhere((element) => 
    element.songname==song.songname);  //if it is present find its index
    int count = mostlyList[indexRecent].count; // find the count of current song
    song.count= count+1; // increment by 1 and update box
    mostlyPlayedBox.put(indexRecent, song);//update the box by the new count of the song
  }
}

updateRecentSearches(RecentSearches song){
  List<RecentSearches> recentSearchesList = recentSearchesBox.values.toList();
  bool isNotPresent = recentSearchesList.where((element)
  {
    return element.songname == song.songname;
  }).isEmpty;
  if (isNotPresent == true) {
    recentSearchesBox.add(song);//if it is not present then add it
  }else{
    int indexRecent = recentSearchesList.indexWhere((element) => 
    element.songname==song.songname);  //if it is present find its index
    recentSearchesBox.deleteAt(indexRecent);  //delete the song at that index 
    recentSearchesBox.add(song); // add again the song to the recentSearchesBox
  }
}



// updateMostlyPlayed(MostlyPlayed song,int index){
//   int count = song.count; // find the count of current song
//   song.count= count+1; // increment by 1 and update box
//   mostlyPlayedBox.put(index, song);
// }