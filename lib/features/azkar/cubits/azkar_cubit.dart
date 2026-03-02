import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/enum.dart';
import '../models/azkar_model.dart';
import 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarStates> {
  AzkarCubit() : super(AzkarInitial());

  Future<void> loadAzkar(ZekrType type) async {
    try {
      emit(AzkarLoading());

      String path = type == ZekrType.morning
          ? 'lib/assets/azkar/azkar_sabah.json'
          : 'lib/assets/azkar/azkar_massa.json';

      final jsonString = await rootBundle.loadString(path);
      final data = json.decode(jsonString);

      final azkarModel = AzkarModel.fromJson(data);

      emit(AzkarSuccess(azkarModel));

    } catch (e) {
      emit(AzkarError(e.toString()));
    }
  }
}