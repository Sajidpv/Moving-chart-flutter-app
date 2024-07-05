import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/theme/color_pellets.dart';
import 'package:haash_moving_chart/cores/theme/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key, required this.onPressed, this.label = 'Add Items'});
  final void Function() onPressed;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(0, 49),
        ),
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return const BorderSide(color: Colors.green, width: 4.0);
            }
            return const BorderSide(color: Colors.grey, width: 1.0);
          },
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          context.read<ThemeProvider>().isDarkMode
              ? AppPallete.gradient2
              : AppPallete.gradient3,
        ),
      ),
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: Text(label!),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;

  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
              backgroundColor: context.read<ThemeProvider>().isDarkMode
                  ? AppPallete.gradient2
                  : AppPallete.gradient3,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)))),
          child: Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          )),
    );
  }
}
