import 'package:isar/isar.dart';

part 'playlist_entity.g.dart';

@collection
class Playlist {
  Id id = Isar.autoIncrement;

  late String name;
  late DateTime createdAt;
  late DateTime updatedAt;

  late List<PlayListTrack> tracks = [];
}

@embedded
class PlayListTrack {
  String? title;
  String? localPath;
}
