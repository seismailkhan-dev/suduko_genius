// lib/app/bindings/game_binding.dart

import 'package:get/get.dart';

import '../../features/game/controller/game_controller.dart';

class GameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(() => GameController());
  }
}
