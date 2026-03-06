import '../data/counter_repository.dart';

class CounterController {

  final CounterRepository _repository;

  final int index;
  final String type;
  final int repeat;
  final int minRequired;
  final int totalAzkar;


  const CounterController({
    required CounterRepository repository,
    required this.index,
    required this.type,
    required this.repeat,
    required this.minRequired,
    required this.totalAzkar,
  }) : _repository = repository;

  /// date
  String get _today {
    final now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}";
  }

  /// counter key
  String get countKey => "${type}_${index}_$_today";

  /// read zekr check key
  String get zekrReadKey => "${type}_zekr_${index}_$_today";

  /// check all zekr completed key
  String get allCompletedKey => "${type}_completed_$_today";

  ///Calculations

  /// get count from storage
  int loadCount() {
    return _repository.getCount(
      countKey,
      defaultValue: repeat,
    );
  }

  int timesRead(int currentCount) => repeat - currentCount;

  bool reachedMinimum(int currentCount) {
    return timesRead(currentCount) >= minRequired;
  }

  bool isFinished(int currentCount) => currentCount == 0;

  bool get isLastZekr => index == totalAzkar - 1;


  double progress(int currentCount) {
    return timesRead(currentCount) / repeat;
  }


  Future<int> decrement(int currentCount) async {
    if (currentCount <= 0) return currentCount;

    final newCount = currentCount - 1;
    await _repository.saveCount(countKey, newCount);
    return newCount;
  }

  Future<int> increment(int currentCount) async {
    if (currentCount >= repeat) return currentCount;

    final newCount = currentCount + 1;
    await _repository.saveCount(countKey, newCount);
    return newCount;
  }



  bool isZekrCompleted(int currentCount) {
    if (isLastZekr) {
      return isFinished(currentCount);
    }
    return reachedMinimum(currentCount);
  }

  Future<bool> handleZekrCompletion(int currentCount) async {
    if (!isZekrCompleted(currentCount)) return false;

    await _repository.markZekrAsRead(zekrReadKey);

    final allDone = await _checkAllAzkarCompleted();
    return allDone;
  }

  Future<bool> _checkAllAzkarCompleted() async {
    for (int i = 0; i < totalAzkar; i++) {
      final key = "${type}_zekr_${i}_$_today";

      if (!_repository.isZekrRead(key)) {
        return false;
      }
    }

    await _repository.markAllCompleted(allCompletedKey);
    return true;
  }
}