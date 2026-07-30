import 'package:isar/isar.dart';
import 'package:just_audio/just_audio.dart';
part 'audiotrack_entity.g.dart';

enum AudioSourceType { assets, file, url }

@collection
class AudioTrack {
  Id id = Isar.autoIncrement;
  late int playListId;
  late String path;

  @enumerated
  late AudioSourceType sourceType; // asset, file, url
}

// metodo ingresar cualquier ruta local/asset/url
Future<AudioSource> buildSource(AudioTrack track) async {
  switch (track.sourceType) {
    case AudioSourceType.assets:
      return AudioSource.asset(track.path);
    case AudioSourceType.file:
      return AudioSource.file(track.path);
    case AudioSourceType.url:
      return AudioSource.uri(Uri.parse(track.path));
  }
}
