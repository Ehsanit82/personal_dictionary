// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_dictionary/src/bloc/word/word_bloc.dart';
import 'package:your_dictionary/src/domain/models/word.dart';

const String LANGUAGE_MODE_KEY = "LANGUAGE_MODE";

abstract class LocalDataSource {

  Box<Word> wordBox(String box);

  Future<void> saveLanguageMode(LanguageMode languageMode);
  Future<String?> getPrefLanguageMode();
}

class LocalDataSourceImpl implements LocalDataSource {
 final SharedPreferences _sharedPreferences;
  LocalDataSourceImpl(
    this._sharedPreferences,
  );

  @override
  Future<void> saveLanguageMode(LanguageMode languageMode) async {
    await _sharedPreferences.setString(LANGUAGE_MODE_KEY, languageMode.name);
  }
  @override
  Future<String?> getPrefLanguageMode() async {
  return _sharedPreferences.getString(LANGUAGE_MODE_KEY);
}

  @override
  Box<Word> wordBox(String box) {
     return Hive.box(box);
  }
}
