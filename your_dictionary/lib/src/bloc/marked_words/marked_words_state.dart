// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'marked_words_bloc.dart';

class MarkedWordsState {
  Limit typeOfLimit;
  MarkedWordsState({
    required this.typeOfLimit,
  });
factory MarkedWordsState.initial(){
  return MarkedWordsState(typeOfLimit: Limit.all);
}
  MarkedWordsState copyWith({
    Limit? typeOfLimit,
  }) {
    return MarkedWordsState(
      typeOfLimit: typeOfLimit ?? this.typeOfLimit,
    );
  }
 }

