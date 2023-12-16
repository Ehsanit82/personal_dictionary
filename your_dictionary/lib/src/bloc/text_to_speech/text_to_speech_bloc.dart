import 'dart:io';
import 'dart:typed_data';

// import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:your_dictionary/src/bloc/word/word_bloc.dart';

import '../../constant/functions.dart';
part 'text_to_speech_event.dart';
part 'text_to_speech_state.dart';

class TextToSpeechBloc extends Bloc<TextToSpeechEvent, TextToSpeechState> {
  TextToSpeechBloc() : super(TextToSpeechState.initial()) {
    on<PlayAudioEvent>((event, emit) async {
      emit(state.copyWith(status: ErrorStatus.initial));
      var appDirectory = await getApplicationDocumentsDirectory();
      const String apiKey = 'd5779820f9b3402680fefc5d757a46e4';
      final String text = event.text;
      final LanguageMode mode  = event.mode;
      late String lanSpeech;
      switch(mode){
        case LanguageMode.En_Fa:
          lanSpeech = "en-us";
        case LanguageMode.De_En:
                   lanSpeech = "de-de";
        case LanguageMode.De_Fa:
                    lanSpeech = "de-de";
      }
      
      final String url =
          'http://api.voicerss.org/?key=$apiKey&hl=$lanSpeech&c=MP3&f=16khz_16bit_stereo&src=$text';
      InternetConnectionChecker _internetChecker = InternetConnectionChecker();
       var response;
      if (await _internetChecker.hasConnection) {
        try {
           response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            // Successfully fetched audio data
            Uint8List audioBytes = response.bodyBytes;

            // Save the audio file locally
            File audioFile = File("${appDirectory.path}/audio.mp3");
            print(audioFile.path);
            await audioFile.writeAsBytes(audioBytes, flush: true);

            // Play the audio file using audioplayers
            final audioPlayer = AudioPlayer();
            await audioPlayer.setFilePath(audioFile.path);
            await audioPlayer.play();
          } else {
            // Request failed with a non-200 status code
            print('Request failed with status: ${response.statusCode}');
            emit(state.copyWith(
                errorMessage:
                    "Some thing went wrong, try again"));
            await Future.delayed(const Duration(seconds: 1));
            emit(state.copyWith(status: ErrorStatus.initial));
          }
        } catch (e) {
          // An error occurred during the request
          print('Error: ${response.statusCode}');
          emit(state.copyWith(
              errorMessage: "Some thing went wrong, try again", status: ErrorStatus.error));
          await Future.delayed(const Duration(seconds: 1));
          emit(state.copyWith(status: ErrorStatus.initial));
        }
      } else {
        emit(state.copyWith(
            errorMessage: "Please check your connection",
            status: ErrorStatus.error));
        await Future.delayed(const Duration(seconds: 1));
        emit(state.copyWith(status: ErrorStatus.initial));

        print(state.errorMessage);
      }
    });
  }
}
