import 'package:alarm_play/core/providers/playlist_controller_provider.dart';
import 'package:alarm_play/data/entities/entities.dart';
import 'package:alarm_play/features/playlists/pendingEntity/pending_track.dart';
import 'package:alarm_play/features/playlists/providers/track_storage_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistCreateScreen extends ConsumerStatefulWidget {
  final Playlist? playList;
  const PlaylistCreateScreen({super.key, this.playList});

  @override
  ConsumerState<PlaylistCreateScreen> createState() =>
      _PlaylistCreateScreenState();
}

class _PlaylistCreateScreenState extends ConsumerState<PlaylistCreateScreen> {
  late TextEditingController _controller;
  late List<PlayListTrack> _tracks;
  late List<PendingTrack> _pendigTracks;
  bool get isEditing => widget.playList != null;
  @override
  void initState() {
    super.initState();
    // se selecciona el nombre de la playList. null ? vacio
    _controller = TextEditingController(text: widget.playList?.name ?? '');
    // se seleccionan los archivos de audio de la playList. null ? vacio
    _tracks = List<PlayListTrack>.from(widget.playList?.tracks ?? []);
    _pendigTracks = [];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// metodo para seleccionar archivos de audio a la lista
  Future<void> _pickAudioFiles() async {
    final newTracks = await ref.read(trackStorageServiceProvider).pickTracks();
    if (!mounted || newTracks.isEmpty) {
      return;
    }
    setState(() {
      _pendigTracks.addAll(newTracks);
    });
  }

// este metodo elimina el archivo de audio de la lista actual. no del DB
  void _removeTrack(int index) {
    setState(() {
      _tracks.removeAt(index);
    });
  }

  Future<void> _save() async {
    final name = _controller.text.trim();
    if (name.isEmpty || _pendigTracks.isEmpty || _tracks.isEmpty) {
      return;
    }
    final controller = ref.read(playListControllerProvider.notifier);
    if (isEditing) {
      final original = widget.playList!;
      final success = await controller.updatePlayList(
          existingTracks: _tracks,
          name: name,
          newTracks: _pendigTracks,
          original: original);
      if (success && mounted) {
        Navigator.of(context).pop();
      }
      return;
    }
    final id = await controller.createPlayList(
        name: name, tracks: List.from(_pendigTracks));
    if (id != null && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controllerState = ref.watch(playListControllerProvider);
    return Scaffold(
      appBar: AppBar(
          title: Text(isEditing ? 'Editar PlayList' : 'Crea tu PlayList')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                    // todo buscar playList en Isar, y guardarla en una variable
                    hintText: widget.playList == null
                        ? 'Nombra tu play list'
                        : widget.playList!.name.toString()),
              ),
              IconButton.filledTonal(
                  onPressed: _pickAudioFiles,
                  icon: Text('Seleccionar Archivos')),
              Expanded(
                  child: ListView.builder(
                itemCount: _tracks.length,
                itemBuilder: (context, index) {
                  final track = _tracks[index];
                  return ListTile(
                    title: Text(track.title ?? 'unknown track'),
                    trailing: IconButton(
                        onPressed: () => _removeTrack(index),
                        icon: Icon(Icons.delete)),
                  );
                },
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controllerState.isLoading ? null : _save
        // todo necesito que visualmente el usuario tenga la misma forma para crear/editar las playList
        // final playListId = ref
        //     .read(playListControllerProvider.notifier)
        //     .createPlayList(name: _controller.text, tracks: tracks);
        /*editar playList
              final success = await .read(playListControllerProvider.notifier)
              .updatePlayList(playList);
              */
        ,
        child: controllerState.isLoading
            ? const CircularProgressIndicator()
            : const Text('Guardar'),
      ),
    );
  }
}
