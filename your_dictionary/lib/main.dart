import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_dictionary/src/bloc/check_validate/check_validate_bloc.dart';
import 'package:your_dictionary/src/bloc/radio_toggle/radio_toggle_bloc.dart';
import 'package:your_dictionary/src/bloc/text_to_speech/text_to_speech_bloc.dart';
import 'package:your_dictionary/src/bloc/word/word_bloc.dart';
import 'package:your_dictionary/src/bloc/word_filter/word_filter_bloc.dart';
import 'package:your_dictionary/src/bloc/word_search/word_search_bloc.dart';
import 'package:your_dictionary/src/domain/models/word.dart';
import 'package:your_dictionary/src/presentation/page_transition.dart';
import 'src/bloc/change_filter_color/change_filter_color_bloc.dart';
import 'src/bloc/definition/definition_bloc.dart';
import 'src/bloc/filtered_words/filtered_words_bloc.dart';
import 'src/bloc/marked_words/marked_words_bloc.dart';
import 'src/constant/functions.dart';
import 'src/presentation/resources/routes_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Word>(WordAdapter());
  await Hive.openBox<Word>(EN_FA_BOX);
  await Hive.openBox<Word>(DE_FA_BOX);
  await Hive.openBox<Word>(DE_EN_BOX);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? mode;
  @override
  void didChangeDependencies() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.containsKey(LANGUAGE_MODE_KEY)) {
        mode = await getPrefLanguageMode();
      }
    super.didChangeDependencies();
    
  }
  @override
  void dispose() async {
    await Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MarkedWordsBloc>(
          create: (context) => MarkedWordsBloc(),
        ),
        BlocProvider<TextToSpeechBloc>(
          create: (context) => TextToSpeechBloc(),
        ),
        BlocProvider<ChangeFilterColorBloc>(
          create: (context) => ChangeFilterColorBloc(),
        ),
        BlocProvider<WordSearchBloc>(
          create: (context) => WordSearchBloc(),
        ),
        BlocProvider<WordFilterBloc>(
          create: (context) => WordFilterBloc(),
        ),
        BlocProvider<FilteredWordsBloc>(
          create: (context) => FilteredWordsBloc(),
        ),
        BlocProvider<CheckValidateBloc>(
          create: (context) => CheckValidateBloc(),
        ),
        BlocProvider<RadioToggleBloc>(
          create: (context) => RadioToggleBloc(),
        ),
        BlocProvider<WordBloc>(
          create: (context) => WordBloc(
            mode: getLanguageMode(mode ?? "")
          ),
        ),
        BlocProvider<DefinitionBloc>(
          create: (context) => DefinitionBloc(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          // pageTransitionsTheme: PageTransitionsTheme(builders: {
          //   TargetPlatform.android: CustomPageTransitionBuilder(),
          //   TargetPlatform.iOS: CustomPageTransitionBuilder(),
          // }),
        ),
        title: 'Your Dictionary',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
      ),
    );
  }
}
