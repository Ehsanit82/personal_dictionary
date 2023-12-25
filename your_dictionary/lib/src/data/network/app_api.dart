
import 'package:your_dictionary/src/data/request/request.dart';
import 'package:http/http.dart' as http;
import '../../constant/functions.dart';

abstract class AppServiceClient {
  Future<http.Response> textToSpeech(TextToSpeechRequest textToSpeechRequest);
}

class AppServiceClientImpl implements AppServiceClient {
  @override
  Future<http.Response> textToSpeech(
      TextToSpeechRequest textToSpeechRequest) async {
    final String url =
        'http://api.voicerss.org/?key=$apiKey&hl=${textToSpeechRequest.lanSpeech}&c=MP3&f=16khz_16bit_stereo&src=${textToSpeechRequest.text}';
    return http.get(Uri.parse(url));
  }
}
