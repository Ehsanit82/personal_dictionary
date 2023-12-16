// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'check_validate_bloc.dart';

class CheckValidateEvent {}

class CheckTitleEvent extends CheckValidateEvent {
  String value;
  CheckTitleEvent({
    required this.value,
  });
}

class CheckDefinitionListEvent extends CheckValidateEvent {
  List<String> faValue;
  List<String> enValue;

  CheckDefinitionListEvent({
    required this.faValue,
    required this.enValue,
  });
   
}

class ResetValidationEvent extends CheckValidateEvent{}