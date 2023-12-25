import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_dictionary/src/bloc/mark_word/mark_word_cubit.dart';
import 'package:your_dictionary/src/domain/models/word.dart';

import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              iconButtonBar(
                Icons.home_filled,
                () {
                  context.read<MarkWordCubit>().setAllWordsEvent();
                },
                Limit.all,
              ),
              iconButtonBar(
                Icons.add_circle_sharp,
                () {
                  Navigator.pushNamed(context, Routes.addWordRoute);
                },
               Limit.nothing,
              ),
              iconButtonBar(
                Icons.bookmarks_rounded,
                () {
                  context.read<MarkWordCubit>().setMarkedWordsEvent();
                },
                Limit.marked
              ),
            ],
          ),
        );
  
  }

  Widget iconButtonBar(IconData icon, VoidCallback function, Limit limit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          splashRadius: 1,
          onPressed: function,
          icon: Icon(
            icon,
            color: ColorManager.primary,
            size: 30,
          ),
        ),
        if (limit == context.watch<MarkWordCubit>().state.typeOfLimit)
          Text(
            "●",
            style: TextStyle(color: ColorManager.primary),
          )
      ],
    );
  }
}
