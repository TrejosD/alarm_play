import 'package:alarm_play/infrastructure/controllers/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playListControllerProvider =
    AsyncNotifierProvider<PlayListController, void>(PlayListController.new);
