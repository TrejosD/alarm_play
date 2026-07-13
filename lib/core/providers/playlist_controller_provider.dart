import 'package:alarm_play/core/controllers/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playListControllerProvider =
    AsyncNotifierProvider<PlayListController, void>(PlayListController.new);
