import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/theme/color_pellets.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: AppPallete.gradient1,
        content: Text(
          content,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
}
