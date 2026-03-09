import '../../../../core/main_repo/main_repo.dart';

class HijriOffsetRepository extends MainRepository {
  const HijriOffsetRepository(super.box);

  static const String _key = 'hijri_day_offset';

  /// Returns the saved offset (default: 0), range: -2 to +2
  int getOffset() => box.get(_key, defaultValue: 0);

  /// Saves the offset value
  Future<void> setOffset(int offset) => box.put(_key, offset.clamp(-2, 2));
}
