
part of 'startup_cubit.dart';

abstract class StartupState {}

class StartupInitial extends StartupState {}

class StartupLoading extends StartupState {}

class StartupEnabled extends StartupState {}

class StartupDisabled extends StartupState {}