import 'package:alarm_play/data/entities/entities.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// este servicio inicia el DB local, llamando al instance desde cualquier parte del app, podemos utilizar el DB.
class IsarService {
  static late final Isar instance;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    instance = await Isar.open([AlarmSchema, PlaylistSchema],
        directory: dir.path, inspector: true);
  }
}
