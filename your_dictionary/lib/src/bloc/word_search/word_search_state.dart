// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'word_search_bloc.dart';

class WordSearchState {
  String searchTerm;
  WordSearchState({
    required this.searchTerm,
  });
factory WordSearchState.initial(){
  return WordSearchState(searchTerm: "");
}
  WordSearchState copyWith({
    String? searchTerm,
  }) {
    return WordSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
 }

