import 'package:alarm_play/data/entities/entities.dart';
import 'package:alarm_play/infrastructure/db/isar_service.dart';
import 'package:alarm_play/infrastructure/navigation/app_router.dart';
import 'package:alarm_play/infrastructure/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// este dialog se muestra antes de Eliminar completamente un playlist
class DeletePlaylistDialog extends ConsumerWidget {
  final Playlist playlist;
  final isar = IsarService.instance;
  DeletePlaylistDialog({super.key, required this.playlist});

  @override
  Widget build(BuildContext context, ref) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          child: Column(
            children: [
              Text(
                'Deseas eliminar esta playlist?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                playlist.name!,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                      onPressed: () => navigatorKey.currentState?.pop(),
                      icon: Text('Cancel')),
                  SizedBox(width: 12),
                  IconButton.filled(
                      onPressed: () {
                        ref
                            .read(playListControllerProvider.notifier)
                            .deletePlayList(playlist.id);
                        navigatorKey.currentState?.pop();
                      },
                      icon: Text(
                        'Aceptar',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
