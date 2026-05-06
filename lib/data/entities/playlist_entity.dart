import 'package:alarm_play/data/entities/audiotrack_entity.dart';
import 'package:isar/isar.dart';

part 'playlist_entity.g.dart';

@collection
class Playlist {
  Id id = Isar.autoIncrement;

  late String name;

  late List<AudioTrack>? tracks;
}
