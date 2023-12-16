// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'word_search_bloc.dart';

 class WordSearchEvent {}
class SetSearchTermEvent extends WordSearchEvent {
  String searchTerm;
  SetSearchTermEvent({
    required this.searchTerm,
  });
}
