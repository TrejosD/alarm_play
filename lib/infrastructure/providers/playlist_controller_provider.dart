import 'package:alarm_play/infrastructure/controllers/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// este provider nos provee el PlayList Controller
final playListControllerProvider =
    AsyncNotifierProvider<PlayListController, void>(PlayListController.new);
