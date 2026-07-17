import 'dart:io';

import 'package:alarm_play/features/playlists/pendingEntity/pending_track.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:alarm_play/data/entities/entities.dart';

// este servicio maneja copiado, eliminado de archivos de audio para nuestras playList
class TrackStorageFileService {
  static const String _folderName = 'playlist_tracks';

// metodo obtiene la carpeta donde guardar los tracks
  Future<Directory> storageDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final directory = Directory(p.join(appDir.path, _folderName));
    // si la carpeta no a sido creada, la crea.
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

// metodo crea una lista de archivos seleccionados temporales, sin guardar en DB
  Future<List<PendingTrack>> pickTracks() async {
    final result =
        await FilePicker.pickFiles(type: FileType.audio, allowMultiple: true);
    if (result == null) {
      return [];
    }
    final tracks = <PendingTrack>[];
    for (final file in result.files) {
      if (file.path == null) continue;
      tracks.add(PendingTrack(title: file.name, originalPath: file.path!));
    }
    return tracks;
  }

// copia los archivos de la memoria del dispositivo a la carpeta del app dentro del dispositivo. Esto evita errores cuando el archivo se mueve o se daña
  Future<List<PlayListTrack>> copyTracks(
      List<PendingTrack> pendingTracks) async {
    final directory = await storageDirectory();
    final copiedTracks = <PlayListTrack>[];
    for (final pending in pendingTracks) {
      final sourceFile = File(pending.originalPath);
      if (!await sourceFile.exists()) {
        continue;
      }
      final extension = p.extension(pending.originalPath);
      final uniqueName = '${DateTime.now().microsecondsSinceEpoch}$extension';
      final destination = File(p.join(directory.path, uniqueName));
      await sourceFile.copy(destination.path);

      copiedTracks.add(PlayListTrack()
        ..title = pending.title
        ..localPath = destination.path
        ..importedAt = DateTime.now()
        ..fileSize = await destination.length());
    }
    return copiedTracks;
  }

// elimina un unico archivo fisico del dispositivo
  Future<void> deleteTrack(PlayListTrack track) async {
    final path = track.localPath;
    if (path == null) return;
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

// permite eliminar todos los tracks de una playList
  Future<void> deletePlaylistFiles(Playlist playlist) async {
    for (final track in playlist.tracks) {
      await deleteTrack(track);
    }
  }

  Future<void> deleteTracks(List<PlayListTrack> tracks) async {
    for (final track in tracks) {
      await deleteTrack(track);
    }
  }

  // verifica si el archivo aun existe
  Future<bool> exists(PlayListTrack track) async {
    final path = track.localPath;
    if (path == null) {
      return false;
    }
    return File(path).exists();
  }

  //Metodo usado por el reproductor de audio, retorna el archivo que utilizara el just_audio
  Future<File> getFile(PlayListTrack track) async {
    final path = track.localPath;
    if (path == null) {
      throw Exception('Track has no localPath');
    }
    final file = File(path);
    if (!await file.exists()) {
      throw Exception('Track file does not exist');
    }
    return file;
  }
}
