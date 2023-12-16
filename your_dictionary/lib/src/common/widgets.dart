
  import 'package:flutter/material.dart';

import '../presentation/resources/color_manager.dart';

Widget defItem(int index, List<String> def, TextDirection direction,
      VoidCallback function) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Directionality(
          textDirection: direction,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    def[index],
                    style: TextStyle(fontSize: 14.0, color: ColorManager.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  splashRadius: 1,
                  iconSize: 20,
                  style: ButtonStyle(
                    iconSize: MaterialStatePropertyAll(10),
                  ),
                  onPressed: function,
                  icon: Icon(
                    Icons.close,
                    color: ColorManager.white,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextFormField(String hintTxt, TextDirection direction,
      TextEditingController controller, Function func) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onFieldSubmitted: (_) => func(),
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        textDirection: direction,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintTxt,
          border: InputBorder.none,
        ),
      ),
    );
  }