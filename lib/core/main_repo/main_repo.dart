import 'package:hive/hive.dart';

abstract class MainRepository {
  Box get box => Hive.box('azkarBox');
}