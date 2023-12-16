import 'package:bloc/bloc.dart';

part 'check_validate_event.dart';
part 'check_validate_state.dart';

class CheckValidateBloc extends Bloc<CheckValidateEvent, CheckValidateState> {
  CheckValidateBloc() : super(CheckValidateState.initial()) {
    on<CheckTitleEvent>((event, emit) {
      emit(state.copyWith(isTitleEmpty: event.value.isEmpty ? true : false));
    });
    on<ResetValidationEvent>((event, emit) {
      emit(state.copyWith(isTitleEmpty: false));
    });
  }
}
