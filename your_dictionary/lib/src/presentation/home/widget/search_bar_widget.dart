import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_dictionary/src/bloc/search_word/search_word_cubit.dart';
import 'package:your_dictionary/src/presentation/resources/routes_manager.dart';
import 'package:your_dictionary/src/presentation/resources/strings_manager.dart';
import '../../resources/color_manager.dart';

class SearchBarWidget extends StatefulWidget {
  SearchBarWidget({Key? key, required this.constraints}) : super(key: key);
  final BoxConstraints constraints;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        height: widget.constraints.maxWidth >= 450
            ? widget.constraints.maxHeight * 0.3
            : widget.constraints.maxHeight * 0.08,
        top: widget.constraints.maxHeight * 0.01,
        right: widget.constraints.maxWidth * 0.005,
        left: widget.constraints.maxWidth * 0.01,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: widget.constraints.maxWidth * 0.1,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.settingsRoute);
                  },
                  icon: Icon(Icons.settings),
                )),
            SizedBox(
              width: widget.constraints.maxWidth * 0.83,
              child: TextField(
                controller: _searchController,
                onChanged: (_) {
                  context
                      .read<SearchWordCubit>()
                      .setSearchTerm(searchTerm: _searchController.text);
                },
                decoration: InputDecoration(
                  hintText: AppStrings.searchWord,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  prefixIcon: BlocBuilder<SearchWordCubit, SearchWordState>(
                    builder: (context, state) {
                      return IconButton(
                        splashRadius: 1,
                        color: ColorManager.primary,
                        onPressed: () {
                          if (state.searchTerm.isNotEmpty) {
                            _searchController.clear();
                            context.read<SearchWordCubit>().setSearchTerm(
                                searchTerm: _searchController.text);
                          }
                        },
                        icon: Icon(
                          state.searchTerm.isNotEmpty ? Icons.close : Icons.search,
                        ),
                      );
                    },
                  ),
                  fillColor: ColorManager.grey,
                ),
              ),
            ),
          ],
        ));
  }
}
