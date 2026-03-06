import 'package:hive/hive.dart';

abstract class MainRepository {
  final Box box;

  const MainRepository(this.box);
}