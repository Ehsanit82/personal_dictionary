import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:your_dictionary/src/presentation/resources/color_manager.dart';

part 'change_filter_color_event.dart';
part 'change_filter_color_state.dart';

class ChangeFilterColorBloc
    extends Bloc<ChangeFilterColorEvent, ChangeFilterColorState> {
  ChangeFilterColorBloc() : super(ChangeFilterColorState.initial()) {
    on<SetColorFilterEvent>((event, emit) {
          emit(state.copyWith(
              colorMap: state.colorMap..update(event.filterIndex, (value) => value == ColorManager.white ?event.color :  ColorManager.white)));
    });
  }
}
