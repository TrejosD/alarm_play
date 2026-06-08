import 'package:alarm_play/data/entities/entities.dart';
import 'package:isar/isar.dart';

part 'playlist_entity.g.dart';

@collection
class Playlist {
  Id id = Isar.autoIncrement;

  late String name;
  late DateTime createAt;
  @ignore
  late List<AudioTrack>? tracks;
}
