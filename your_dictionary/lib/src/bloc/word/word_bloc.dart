// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:your_dictionary/src/constant/functions.dart';
import '../../domain/models/word.dart';
import '../../presentation/resources/color_manager.dart';

part 'word_event.dart';
part 'word_state.dart';

const String LANGUAGE_MODE_KEY = "LANGUAE_MODE";

class WordBloc extends Bloc<WordEvent, WordState> {
  LanguageMode mode;
  WordBloc({required this.mode}) : super(WordState.initial(mode)) {
    on<ChangeLanguageModeEvent>((event, emit) async {
      await setPrefLanguageMode(event.mode);
      emit(state.copyWith(mode: event.mode));
      add(FetchWordsEvent());
    });
    on<AddWordEvent>((event, emit) async {
      var box = getStringLanguageMode(state.mode);
      Box<Word> wordBox = Hive.box(box);
      Word wordData = Word(
        title: event.wordData.title,
        secMeaning: event.wordData.secMeaning,
        mainMeaning: event.wordData.mainMeaning,
        mainExample: event.wordData.mainExample,
        noun: event.wordData.noun,
        verb: event.wordData.verb,
        adj: event.wordData.adj,
        adverb: event.wordData.adverb,
        phrases: event.wordData.phrases,
        isMarked: event.wordData.isMarked,
      );
      wordBox.add(wordData);
      emit(state.copyWith(wordList: state.wordList..add(wordData)));
    });
    on<FetchWordsEvent>((event, emit) {
      var box = getStringLanguageMode(state.mode);
      Box<Word> wordBox = Hive.box(box);
      List<Word> fetchData = wordBox.values.toList();
      emit(state.copyWith(wordList: fetchData));
    });

    on<RemoveWordEvent>((event, emit) {
      var box = getStringLanguageMode(state.mode);
      Box<Word> wordBox = Hive.box(box);
      int index = state.wordList.indexWhere((word) => word.id == event.id);
      wordBox.deleteAt(index);
      List<Word> _word = state.wordList
        ..removeWhere((element) => element.id == event.id);
      emit(state.copyWith(wordList: _word));
    });

    on<UpdateWordEvent>((event, emit) async {
      var box = getStringLanguageMode(state.mode);
      Box<Word> wordBox = Hive.box(box);
      state.wordList.removeAt(event.index);
      state.wordList.insert(event.index, event.updatedWord);
      emit(state.copyWith(wordList: state.wordList));
      await wordBox.putAt(event.index, event.updatedWord);
    });
    on<AddToMarkedWordsEvent>((event, emit) async {
      var box = getStringLanguageMode(state.mode);
      Box<Word> wordBox = Hive.box(box);
      state.wordList.removeAt(event.index);
      Word updatedWord = Word(
          id: event.updatedWord.id,
          title: event.updatedWord.title,
          secMeaning: event.updatedWord.secMeaning,
          mainMeaning: event.updatedWord.mainMeaning,
          mainExample: event.updatedWord.mainExample,
          isMarked: !event.updatedWord.isMarked,
          adj: event.updatedWord.adj,
          adverb: event.updatedWord.adverb,
          noun: event.updatedWord.noun,
          phrases: event.updatedWord.phrases,
          verb: event.updatedWord.verb);
      state.wordList.insert(event.index, updatedWord);
      await wordBox.putAt(event.index, updatedWord);
      emit(state.copyWith(wordList: state.wordList));
    });
    on<ExportDataEvent>((event, emit) {
      try {
        List<Map<String, dynamic>> data = [];
        for (var word in state.wordList) {
          data.add(word.toJson(word));
        }
        event.exportFile.writeAsStringSync(jsonEncode(data),
            mode: FileMode.writeOnly, flush: true);
       String? message = "Saved at: ${event.exportFile.path}";
        showNotification(message);
      } catch (e) {
        print(e);
      }
    });
    on<ImportDataEvent>((event, emit) {
      String? message;
      try {
        String fileContents = event.importFile.readAsStringSync();
        List<dynamic> readData = jsonDecode(fileContents);
        for (var word in readData) {
          add(AddWordEvent(wordData: Word.fromJson(word)));
        }
        message = "Import was successfully";
        showNotification(message);
      } catch (e) {
        message = "Import was not successfully";
        showNotification(message);
      }
    });
  }
}
