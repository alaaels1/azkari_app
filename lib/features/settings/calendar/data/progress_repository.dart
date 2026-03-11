import '../../../../core/main_repo/main_repo.dart';



class ProgressRepository extends MainRepository {
  bool isCompletedOnDay(String type, DateTime day) =>
      box.get(_buildKey(type, day), defaultValue: false);

  String _buildKey(String type, DateTime day) =>
      '${type}_completed_${day.year}-${day.month}-${day.day}';
}