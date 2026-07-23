import 'package:alarm_play/core/providers/providers.dart';
import 'package:alarm_play/presentations/screens/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistSelectorDialog extends ConsumerWidget {
  const PlaylistSelectorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ScrollController();
    final playList = ref.read(playlistListProvider);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text('Selecciona tu playlist favorita'),
      content: playList.when(
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text('Error ${error.toString()}'),
        ),
        data: (data) {
          if (data.isEmpty) {
            return Center(child: Text('Aun no tienes playList creadas'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SingleChildScrollView(
                controller: controller,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return GestureDetector(
                      onTap: () {
                        // este metodo debe enviar el playListid a nuestra alarma
                      },
                      child: ListTile(
                        title: Text(item.name!),
                        subtitle:
                            Text('Songs ${item.tracks.length.toString()}'),
                      ),
                    );
                  },
                )),
          );
        },
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PlaylistCreateScreen(),
              ));
            },
            child: Text('Crear nueva'))
      ],
    );
  }
}
