import 'dart:io';

import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/widgets/alert_dialogs.dart';

class WillPopScopWidget extends StatelessWidget {
  const WillPopScopWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          showCustomAlertDialog(
              context: context,
              title: 'Are you sure?',
              action: 'Leave🚶‍♂️',
              backAction: 'Nevermind😏',
              content: 'Are you sure you want to leave this app?',
              onConfirm: () {
                exit(0);
              });
        },
        child: child);
  }
}
