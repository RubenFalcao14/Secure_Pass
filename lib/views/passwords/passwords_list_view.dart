import 'package:flutter/material.dart';
import 'package:secure_pass/services/cloud/cloud_password.dart';
import 'package:secure_pass/utilities/dialogs/delete_dialog.dart';

typedef PasswordCallback = void Function(CloudPassword password);

class PasswordsListView extends StatelessWidget {
  final Iterable<CloudPassword> passwords;
  final PasswordCallback onDeletePassword;
  final PasswordCallback onTap;

  const PasswordsListView({
    Key? key,
    required this.passwords,
    required this.onDeletePassword,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: passwords.length,
      itemBuilder: (context, index) {
        final password = passwords.elementAt(index);
        return ListTile(
          onTap: () {
            onTap(password);
          },
          title: Text(
            password.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDeletePassword(password);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
