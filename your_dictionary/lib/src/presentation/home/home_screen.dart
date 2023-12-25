import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_dictionary/src/bloc/mark_word/mark_word_cubit.dart';
import 'package:your_dictionary/src/presentation/home/widget/custom_bottom_navigation_bar.dart';
import 'package:your_dictionary/src/presentation/home/widget/search_bar_widget.dart';
import 'package:your_dictionary/src/presentation/home/widget/word_filter.dart';
import 'package:your_dictionary/src/presentation/home/widget/word_list_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
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
                        limit: context.watch<MarkWordCubit>().state.typeOfLimit,
                      ),
                    ],
                  ),
                );
              },
            )
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

 
}
