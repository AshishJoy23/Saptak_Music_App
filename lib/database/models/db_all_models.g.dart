// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_all_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllSongsAdapter extends TypeAdapter<AllSongs> {
  @override
  final int typeId = 0;

  @override
  AllSongs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllSongs(
      songname: fields[0] as String?,
      artist: fields[1] as String?,
      duration: fields[2] as int?,
      id: fields[4] as int?,
      songuri: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AllSongs obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.songname)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songuri)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllSongsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentlyPlayedAdapter extends TypeAdapter<RecentlyPlayed> {
  @override
  final int typeId = 1;

  @override
  RecentlyPlayed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlyPlayed(
      songname: fields[0] as String?,
      artist: fields[1] as String?,
      duration: fields[2] as int?,
      songuri: fields[3] as String?,
      id: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlyPlayed obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.songname)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songuri)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyPlayedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MostlyPlayedAdapter extends TypeAdapter<MostlyPlayed> {
  @override
  final int typeId = 2;

  @override
  MostlyPlayed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MostlyPlayed(
      songname: fields[0] as String,
      songuri: fields[3] as String?,
      duration: fields[2] as int?,
      artist: fields[1] as String?,
      count: fields[4] as int,
      id: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MostlyPlayed obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.songname)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songuri)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MostlyPlayedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavoritesAdapter extends TypeAdapter<Favorites> {
  @override
  final int typeId = 3;

  @override
  Favorites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorites(
      songname: fields[0] as String?,
      artist: fields[1] as String?,
      duration: fields[2] as int?,
      songuri: fields[3] as String?,
      id: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Favorites obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.songname)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songuri)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlaylistsAdapter extends TypeAdapter<Playlists> {
  @override
  final int typeId = 4;

  @override
  Playlists read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlists(
      playlistname: fields[0] as String?,
      playlistssongs: (fields[1] as List?)?.cast<AllSongs>(),
    );
  }

  @override
  void write(BinaryWriter writer, Playlists obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistname)
      ..writeByte(1)
      ..write(obj.playlistssongs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentSearchesAdapter extends TypeAdapter<RecentSearches> {
  @override
  final int typeId = 5;

  @override
  RecentSearches read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentSearches(
      songname: fields[0] as String?,
      artist: fields[1] as String?,
      duration: fields[2] as int?,
      songuri: fields[3] as String?,
      id: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentSearches obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.songname)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songuri)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentSearchesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
