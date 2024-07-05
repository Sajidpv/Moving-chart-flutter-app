import 'package:flutter/cupertino.dart';

class SpacerWidget extends StatelessWidget {
  const SpacerWidget({super.key, this.height = 10, this.width = 10});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
