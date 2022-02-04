import 'package:hive/hive.dart';

abstract class LocalBox {
  late Box box;

  String get name;

  Future openBox() async {
    box = await Hive.openBox(name);
  }

  Future clearBox() async {
    box.clear();
  }
}
