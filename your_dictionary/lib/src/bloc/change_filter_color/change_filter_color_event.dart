// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_filter_color_bloc.dart';

 class ChangeFilterColorEvent {}
class SetColorFilterEvent extends ChangeFilterColorEvent {
  int filterIndex;
  Color color;
  SetColorFilterEvent({
    required this.filterIndex,
    required this.color,
  });
 }
