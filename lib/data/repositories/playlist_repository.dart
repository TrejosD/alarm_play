import 'package:alarm_play/data/entities/entities.dart';
import 'package:isar/isar.dart';

class PlaylistRepository {
  final Isar isar;

  PlaylistRepository({required this.isar});

  Future<Playlist?> getById(int id) async {
    return isar.playlists.get(id);
  }

  Future<int> create(Playlist playList) async {
    return isar.writeTxn(() async {
      print('NUeva playList creada');
      return isar.playlists.put(playList);
    });
  }

  Future<void> update(Playlist playList) async {
    playList.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.playlists.put(playList);
    });
  }

  Future<void> delete(int playListId) async {
    await isar.writeTxn(() async {
      await isar.playlists.delete(playListId);
    });
  }
}
