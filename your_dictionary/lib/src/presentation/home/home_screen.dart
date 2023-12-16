import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:your_dictionary/src/bloc/marked_words/marked_words_bloc.dart';
import 'package:your_dictionary/src/bloc/text_to_speech/text_to_speech_bloc.dart';
import 'package:your_dictionary/src/presentation/home/widget/custom_bottom_navigation_bar.dart';
import 'package:your_dictionary/src/presentation/home/widget/search_bar_widget.dart';
import 'package:your_dictionary/src/presentation/home/widget/word_filter.dart';
import 'package:your_dictionary/src/presentation/home/widget/word_list_widget.dart';
import 'package:your_dictionary/src/presentation/resources/color_manager.dart';

import '../../constant/functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BlocBuilder<TextToSpeechBloc, TextToSpeechState>(
              builder: (context, state) {
                if (state.status == ErrorStatus.error) {
                  Fluttertoast.showToast(
                      msg: state.errorMessage!,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: ColorManager.primary,
                      fontSize: 14);
                }
                return SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Stack(
                    children: [
                      SearchBarWidget(
                        constraints: constraints,
                      ),
                      WordFilterWidget(constraints: constraints),
                      WordListWidget(
                        constraints: constraints,
                        limit: context.watch<MarkedWordsBloc>().state.typeOfLimit,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

 
}
