import 'package:alarm_play/infrastructure/providers/playlist_controller_provider.dart';
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

// todo agrarrarme con esta screen y dejarla bonita
class _PlaylistCreateScreenState extends ConsumerState<PlaylistCreateScreen> {
  late TextEditingController _controller;
  late List<PlayListTrack> _tracks;
  late List<UITracks> _uiTracks;
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
    _uiTracks = [];
    _mergeLists();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _mergeLists() {
    _uiTracks.clear();
    final tracks = _createUITrackList(_tracks, 'tracks');
    final pending = _createUITrackList(_pendigTracks, 'pending');
    _uiTracks.addAll(tracks);
    _uiTracks.addAll(pending);
  }

  List<UITracks> _createUITrackList(List tracks, String indentifier) {
    List<UITracks> list = [];
    int index = 0;
    for (final item in tracks) {
      index++;
      final newTrack = UITracks(item.title, indentifier, index);
      list.add(newTrack);
    }
    index = 0;
    return list;
  }

// metodo para seleccionar archivos de audio a la lista
  Future<void> _pickAudioFiles() async {
    final newTracks = await ref.read(trackStorageServiceProvider).pickTracks();
    if (!mounted || newTracks.isEmpty) {
      return;
    }
    setState(() {
      _pendigTracks.addAll(newTracks);
      _mergeLists();
    });
  }

// este metodo elimina el archivo de audio de la lista actual. no del DB
  void _removeTrack(int index) {
    final track = _uiTracks[index];
    switch (track.indentifier) {
      case 'pending':
        _pendigTracks.removeAt(track.index - 1);
        break;
      case 'tracks':
        _tracks.removeAt(track.index - 1);
    }
    setState(() {
      _uiTracks.removeAt(index);
    });
  }

  // aca estoy creando una lista, para el UI con el metodo remotrack solo se elimina del UI.
  // hasta que no se salva no tenemos escritura en DB
  // creo que necesitaria una sola lista, para mostrar y eliminar del UI. luego el guardado en DB,

  Future<void> _save() async {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      return;
      //deberia tener una evaluacion del form y mostrar el error en UI
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                      // todo buscar playList en Isar, y guardarla en una variable
                      hintText: widget.playList == null
                          ? 'Nombra tu play list'
                          : widget.playList!.name.toString()),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              IconButton.filledTonal(
                  onPressed: _pickAudioFiles,
                  icon: Text('Seleccionar Archivos')),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _uiTracks.length,
                itemBuilder: (context, index) {
                  final track = _uiTracks[index];
                  return ListTile(
                    title: Text(track.title ?? 'unknown track'),
                    trailing: IconButton(
                        onPressed: () => _removeTrack(index),
                        icon: Icon(Icons.delete)),
                  );
                },
              )
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
            : const Text('Save'),
      ),
    );
  }
}

class UITracks {
  String? title;
  String indentifier;
  int index;
  UITracks(this.title, this.indentifier, this.index);
}
