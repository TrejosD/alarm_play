import 'package:alarm_play/data/entities/entities.dart';
import 'package:isar/isar.dart';

// este es nuestro repositorio de playlist, contiene los metodos para escribir, eliminar y actualizar en DB
class PlaylistRepository {
  final Isar isar;

  PlaylistRepository({required this.isar});
// metodo para buscar una playList por ID
  Future<Playlist?> getById(int id) async {
    return isar.playlists.get(id);
  }

// metodo para crear nuevas playlist
  Future<int> create(Playlist playList) async {
    return isar.writeTxn(() async {
      return isar.playlists.put(playList);
    });
  }

// metodo para actualizar playlist
  Future<void> update(Playlist playList) async {
    playList.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.playlists.put(playList);
    });
  }

// metodo para eliminar playlist
  Future<void> delete(int playListId) async {
    await isar.writeTxn(() async {
      await isar.playlists.delete(playListId);
    });
  }
}
