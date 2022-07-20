import 'package:flutter/material.dart';
import 'package:secure_pass/constants/routes.dart';
import 'package:secure_pass/enums/menu_action.dart';
import 'package:secure_pass/services/auth/auth_service.dart';
import 'package:secure_pass/services/cloud/cloud_password.dart';
import 'package:secure_pass/services/cloud/firebase_cloud_storage.dart';
import 'package:secure_pass/utilities/dialogs/logout_dialog.dart';
import 'package:secure_pass/views/passwords/passwords_list_view.dart';

class PasswordsView extends StatefulWidget {
  const PasswordsView({Key? key}) : super(key: key);

  @override
  _PasswordsViewState createState() => _PasswordsViewState();
}

class _PasswordsViewState extends State<PasswordsView> {
  late final FirebaseCloudStorage _passwordsService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _passwordsService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Passwords'),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(createOrUpdatePasswordRoute);
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false,
                    );
                  }
                  break;
                case MenuAction.passwordGenerator:
                  Navigator.of(context).pushNamed(passwordGeneratorRoute);
                  break;
                case MenuAction.settings:
                  Navigator.of(context).pushNamed(settingsRoute);
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.passwordGenerator,
                  child: Text('Password Generator'),
                ),
                PopupMenuItem<MenuAction>(
                  value: MenuAction.settings,
                  child: Text('Settings'),
                ),
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                ),
              ];
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _passwordsService.allPasswords(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allPasswords = snapshot.data as Iterable<CloudPassword>;
                return PasswordsListView(
                  passwords: allPasswords,
                  onDeletePassword: (password) async {
                    await _passwordsService.deletePassword(documentId: password.documentId);
                  },
                  onTap: (password) {
                    Navigator.of(context).pushNamed(
                      createOrUpdatePasswordRoute,
                      arguments: password,
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
