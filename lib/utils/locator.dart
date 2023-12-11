import 'package:get_it/get_it.dart';
import 'package:language_voice_bot/controller/state_controller.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<StateController>(() => StateController());
}
