import 'package:note_app/config/constant/app_constant.dart';

abstract class BaseHiveModel<T> {
  String id;

  BaseHiveModel({String? id}) : id = id ?? uuid.v4();
}
