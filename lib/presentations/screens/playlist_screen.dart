import 'package:flutter/material.dart';

class PlaylistCreateScreen extends StatefulWidget {
  final int? playListId;
  const PlaylistCreateScreen({super.key, this.playListId});

  @override
  State<PlaylistCreateScreen> createState() => _PlaylistCreateScreenState();
}

class _PlaylistCreateScreenState extends State<PlaylistCreateScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.playListId != null
            ? Text('Editar PlayList')
            : Text('Crea tu PlayList'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Nombre de playList'),
            IconButton.filledTonal(
                onPressed: () {}, icon: Text('Seleccionar Archivos')),
            Column(
              children: [
                Text('Track 1'),
                Text('Track 2'),
                Text('Track 3'),
                Text('Track 4')
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('Guardar'),
      ),
    );
  }
}
