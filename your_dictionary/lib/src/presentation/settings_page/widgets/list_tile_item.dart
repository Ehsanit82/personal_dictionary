import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';

Widget listTileItem(BoxConstraints constraints, String title, VoidCallback func,
    Widget trailing) {
  return SizedBox(
    height: constraints.maxWidth > 450 ? constraints.maxHeight * 0.15 : constraints.maxHeight * 0.08,
    width: constraints.maxWidth,
    child: GestureDetector(
      onTap: func,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.60,
              child: Text(
                title,
                style: TextStyle(
                    color: ColorManager.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
                width: constraints.maxWidth * 0.30,
                child: Center(child: trailing)),
          ],
        ),
      ),
    ),
  );
}
