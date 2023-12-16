// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'check_validate_bloc.dart';

class CheckValidateState {
  bool isTitleEmpty;
  bool isDefinitionListsEmpty;
  bool isTypeEmpty;
  CheckValidateState({
    required this.isTitleEmpty,
    required this.isDefinitionListsEmpty,
    required this.isTypeEmpty,
  });

  factory CheckValidateState.initial() {
    return CheckValidateState(
      isTitleEmpty: false,
      isDefinitionListsEmpty: false,
      isTypeEmpty: false,
    );
  }
  CheckValidateState copyWith({
    bool? isTitleEmpty,
    bool? isDefinitionListsEmpty,
    bool? isTypeEmpty,
  }) {
    return CheckValidateState(
      isTitleEmpty: isTitleEmpty ?? this.isTitleEmpty,
      isDefinitionListsEmpty: isDefinitionListsEmpty ?? this.isDefinitionListsEmpty,
      isTypeEmpty: isTypeEmpty ?? this.isTypeEmpty,
    );
  }
}
