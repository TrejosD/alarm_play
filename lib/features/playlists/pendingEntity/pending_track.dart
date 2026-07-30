// esta entidad la utilizamos para manejar visualmente los archivos de audio que aun no estan guardados en almacenamiento local
class PendingTrack {
  String title;
  String originalPath;
  PendingTrack({required this.title, required this.originalPath});
}
