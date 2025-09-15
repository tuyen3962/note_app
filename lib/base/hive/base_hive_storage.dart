import 'package:hive/hive.dart';

import 'base_hive_model.dart';

abstract class BaseHiveStorage<T extends BaseHiveModel> {
  String get boxName => '';

  late final Box box;

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson(T value);

  Future<void> init() async {
    box = await Hive.openBox(boxName);
  }

  void upsert(T value) {
    box.put(value.id, toJson(value));
  }

  Future delete(T value) async {
    return box.delete(value.id);
  }

  Future deleteAll() async {
    return box.clear();
  }

  T? get(String id) {
    try {
      final data = box.get(id, defaultValue: null);
      if (data == null) return null;
      return fromJson(data);
    } catch (e) {
      return null;
    }
  }

  Future close() async {
    return box.close();
  }
}
