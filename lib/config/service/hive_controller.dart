import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:note_app/base/hive/base_hive_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'app_service.dart';

@injectable
class HiveController {
  List<BaseHiveStorage> get storages => [];

  HiveController();

  @preResolve
  Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    for (final storage in storages) {
      await storage.init();
      locator.registerSingleton(storage);
    }
  }

  @disposeMethod
  Future<void> dispose() async {
    for (final storage in storages) {
      await storage.close();
    }
  }
}
