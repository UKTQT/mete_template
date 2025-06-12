import 'package:com_nectrom_metetemplate/core/base/base_cubit.dart';
import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'example_cubit_state.dart';

class ExampleCubit extends BaseCubit<ExampleCubitState> {
  ExampleCubit({required BuildContext context}) : super(const ExampleCubitState()) {
    init(context: context);
  }

  Future<void> init({required BuildContext context}) async {
    LoggerManager.instance.debug("ExampleCubit çalıştırılıyor.");

    safeEmit(
      state.copyWith(context: context),
    );
  }
}
