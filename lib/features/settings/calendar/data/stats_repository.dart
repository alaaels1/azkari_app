import '../../../../core/main_repo/main_repo.dart';


class StatsRepository extends MainRepository {
  Set<String> _getUniqueDates() {
    final Set<String> dates = {};
    for (final key in box.keys) {
      if (key.toString().contains('_completed_')) {
        final date = key.toString().split('_completed_').last;
        dates.add(date);
      }
    }
    return dates;
  }

  Map<String, int> calculateStats() {
    int morningOnly = 0;
    int eveningOnly = 0;
    int both = 0;

    for (final date in _getUniqueDates()) {
      final morning = box.get('morning_completed_$date', defaultValue: false);
      final evening = box.get('evening_completed_$date', defaultValue: false);

      if (morning && evening) {
        both++;
      } else if (morning) {
        morningOnly++;
      } else if (evening) {
        eveningOnly++;
      }
    }

    return {'morning': morningOnly, 'evening': eveningOnly, 'both': both};
  }

  int calculateStreak() {
    int streak = 0;
    DateTime day = DateTime.now();

    while (true) {
      final morning = box.get(
        'morning_completed_${day.year}-${day.month}-${day.day}',
        defaultValue: false,
      );
      final evening = box.get(
        'evening_completed_${day.year}-${day.month}-${day.day}',
        defaultValue: false,
      );

      if (morning && evening) {
        streak++;
        day = day.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }
}