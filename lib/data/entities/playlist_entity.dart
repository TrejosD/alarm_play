import 'package:isar/isar.dart';

part 'playlist_entity.g.dart';

@collection
class Playlist {
  // id lo usa isar
  Id id = Isar.autoIncrement;
// nombre de nuestra playlist
  String? name;

  late DateTime createdAt;
  late DateTime updatedAt;
// lista de archivos de audio a reproducir
  late List<PlayListTrack> tracks = [];
}

@embedded
class PlayListTrack {
  String? title;
  String? localPath;
  int? fileSize;
  DateTime? importedAt;
}
