import 'package:flutter/material.dart';
import 'package:secure_pass/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyPasswordDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Sharing',
    content: 'You cannot share an empty password!',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
