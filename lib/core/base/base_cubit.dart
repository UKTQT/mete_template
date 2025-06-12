import 'package:com_nectrom_metetemplate/core/managers/logger_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<T> extends Cubit<T> with WidgetsBindingObserver {
  BaseCubit(super.initialState) {
    WidgetsBinding.instance.addObserver(this);
  }

  final LoggerManager _logger = LoggerManager.instance;

  /// Cubit kapalı değilse güvenli şekilde state yayımı yapar ve loglar
  void safeEmit(T state) {
    if (!isClosed) {
      emit(state);
      _logger.info('State changed: ${state.runtimeType}');
    }
  }

  /// Verilen Cubit örneğini güvenli şekilde kapatır
  void closeCubit(BlocBase cubit) {
    if (!cubit.isClosed) {
      cubit.close();
      _logger.info('Cubit closed: ${cubit.runtimeType}');
    }
  }

  /// Cubit kapatıldığında observer'dan kaldırılır
  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  /// State değişimlerini loglama veya dinleme amaçlı override edebilirsin
  @override
  void onChange(Change<T> change) {
    super.onChange(change);
  }

  /// Hatalar loglanabilir veya crash takip araçlarına yönlendirilebilir
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
