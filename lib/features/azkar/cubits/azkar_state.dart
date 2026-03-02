import '../models/azkar_model.dart';

abstract class AzkarStates {}

class AzkarInitial extends AzkarStates {}

class AzkarLoading extends AzkarStates {}

class AzkarSuccess extends AzkarStates {
  final AzkarModel azkarModel;

  AzkarSuccess(this.azkarModel);
}

class AzkarError extends AzkarStates {
  final String error;

  AzkarError(this.error);
}