// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_filter_color_bloc.dart';

class ChangeFilterColorState {
  Map<int, Color> colorMap;
  ChangeFilterColorState({
    required this.colorMap,
  });
  factory ChangeFilterColorState.initial() {
    return ChangeFilterColorState(colorMap: {
      0: ColorManager.white, // noun
      1: ColorManager.white, // verb
      2: ColorManager.white, // adjective
      3: ColorManager.white, // adverb
      4: ColorManager.white, // phrases
    });
  }
  ChangeFilterColorState copyWith({
    Map<int, Color>? colorMap,
  }) {
    return ChangeFilterColorState(
      colorMap: colorMap ?? this.colorMap,
    );
  }
}
