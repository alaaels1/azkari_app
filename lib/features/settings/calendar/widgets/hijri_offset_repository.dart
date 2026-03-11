import '../../../../core/main_repo/main_repo.dart';

class HijriOffsetRepository extends MainRepository {
  static const String _key = 'hijri_day_offset';

  int getOffset() => box.get(_key, defaultValue: 0);

  Future<void> setOffset(int offset) => box.put(_key, offset.clamp(-2, 2));
}