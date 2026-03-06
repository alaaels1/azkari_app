import '../../../../core/main_repo/main_repo.dart';


class ProgressRepository extends MainRepository {
  const ProgressRepository(super.box);

  bool isCompletedOnDay(String type, DateTime day) {
    final key = _buildKey(type, day);
    return box.get(key, defaultValue: false);
  }

  String _buildKey(String type, DateTime day) =>
      "${type}_completed_${day.year}-${day.month}-${day.day}";
}