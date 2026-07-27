import 'package:alarm_play/data/entities/entities.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late final Isar instance;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    instance = await Isar.open([AlarmSchema, PlaylistSchema],
        directory: dir.path, inspector: true);
  }
}
