import 'package:bloc/bloc.dart';

part 'word_search_event.dart';
part 'word_search_state.dart';

class WordSearchBloc extends Bloc<WordSearchEvent, WordSearchState> {
  WordSearchBloc() : super(WordSearchState.initial()) {
    on<SetSearchTermEvent>((event, emit) {
      emit(state.copyWith(searchTerm: event.searchTerm));
    });
  }
}
