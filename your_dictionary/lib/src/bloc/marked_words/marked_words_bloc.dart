import 'package:bloc/bloc.dart';

import '../../domain/models/word.dart';

part 'marked_words_event.dart';
part 'marked_words_state.dart';

class MarkedWordsBloc extends Bloc<MarkedWordsEvent, MarkedWordsState> {
  MarkedWordsBloc() : super(MarkedWordsState.initial()) {
    on<SetAllWordsEvent>((event, emit) {
      emit(state.copyWith(typeOfLimit: Limit.all));
    });
    on<SetMarkedWordsEvent>((event, emit) {
      emit(state.copyWith(typeOfLimit: Limit.marked));
    });
  }
}
