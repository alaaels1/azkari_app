import 'package:azkari_app/core/main_repo/main_repo.dart';

class CounterRepository extends MainRepository {
  const CounterRepository(super.box);


  int getCount(String key, {required int defaultValue}) =>
      box.get(key, defaultValue: defaultValue);

  bool isZekrRead(String zekrKey) =>
      box.get(zekrKey, defaultValue: false);

  bool isAllCompleted(String completedKey) =>
      box.get(completedKey, defaultValue: false);


  Future<void> saveCount(String key, int count) async =>
      await box.put(key, count);

  Future<void> markZekrAsRead(String zekrKey) async {
    if (!isZekrRead(zekrKey)) {
      await box.put(zekrKey, true);
    }
  }

  Future<void> markAllCompleted(String completedKey) async {
    if (!isAllCompleted(completedKey)) {
      await box.put(completedKey, true);
    }
  }
}