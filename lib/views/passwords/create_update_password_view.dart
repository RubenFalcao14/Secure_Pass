import 'package:flutter/material.dart';
import 'package:secure_pass/services/auth/auth_service.dart';
import 'package:secure_pass/utilities/dialogs/cannot_share_empty_password_dialog.dart';
import 'package:secure_pass/utilities/generics/get_arguments.dart';
import 'package:secure_pass/services/cloud/cloud_password.dart';
import 'package:secure_pass/services/cloud/firebase_cloud_storage.dart';
import 'package:share_plus/share_plus.dart';

class CreateUpdatePasswordView extends StatefulWidget {
  const CreateUpdatePasswordView({Key? key}) : super(key: key);

  @override
  _CreateUpdatePasswordViewState createState() => _CreateUpdatePasswordViewState();
}

class _CreateUpdatePasswordViewState extends State<CreateUpdatePasswordView> {
  CloudPassword? _password;
  late final FirebaseCloudStorage _passwordsService;
  late final TextEditingController _emailController;
  late final TextEditingController _titleController;
  late final TextEditingController _userPasswordController;
  late final TextEditingController _urlController;

  @override
  void initState() {
    _passwordsService = FirebaseCloudStorage();
    _titleController = TextEditingController();
    _emailController = TextEditingController();
    _userPasswordController = TextEditingController();
    _urlController = TextEditingController();
    super.initState();
  }

  void _titleControllerListener() async {
    final password = _password;
    if (password == null) {
      return;
    }
    final title = _titleController.text;
    await _passwordsService.updatePassword(
      documentId: password.documentId,
      text: title,
    );
  }

  void _emailControllerListener() async {
    final password = _password;
    if (password == null) {
      return;
    }
    final email = _emailController.text;
    await _passwordsService.updatePassword(
      documentId: password.documentId,
      text: email,
    );
  }

  void _userPasswordControllerListener() async {
    final password = _password;
    if (password == null) {
      return;
    }
    final userpassword = _userPasswordController.text;
    await _passwordsService.updatePassword(
      documentId: password.documentId,
      text: userpassword,
    );
  }

  void _urlControllerListener() async {
    final password = _password;
    if (password == null) {
      return;
    }
    final url = _urlController.text;
    await _passwordsService.updatePassword(
      documentId: password.documentId,
      text: url,
    );
  }

  void _setupTextControllerListener() {
    _titleController.removeListener(_titleControllerListener);
    _titleController.addListener(_titleControllerListener);
    _emailController.removeListener(_emailControllerListener);
    _emailController.addListener(_emailControllerListener);
    _userPasswordController.removeListener(_userPasswordControllerListener);
    _userPasswordController.addListener(_userPasswordControllerListener);
    _urlController.removeListener(_urlControllerListener);
    _urlController.addListener(_urlControllerListener);
  }

  Future<CloudPassword> createOrGetExistingPassword(BuildContext context) async {
    final widgetPassword = context.getArgument<CloudPassword>();

    if (widgetPassword != null) {
      _password = widgetPassword;
      _titleController.text = widgetPassword.title;
      _emailController.text = widgetPassword.email;
      _userPasswordController.text = widgetPassword.userpassword;
      _urlController.text = widgetPassword.url;
      return widgetPassword;
    }

    final existingPassword = _password;
    if (existingPassword != null) {
      return existingPassword;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newPassword = await _passwordsService.createNewPassword(ownerUserId: userId);
    _password = newPassword;
    return newPassword;
  }

  void _deletePasswordIfTextIsEmpty() {
    final password = _password;
    if (_titleController.text.isEmpty && _emailController.text.isEmpty && _userPasswordController.text.isEmpty && _urlController.text.isEmpty && password != null) {
      _passwordsService.deletePassword(documentId: password.documentId);
    }
  }

  void _savePasswordIfTextNotEmpty() async {
    final password = _password;
    final title = _titleController.text;
    final email = _emailController.text;
    final userpassword = _userPasswordController.text;
    final url = _urlController.text;
    if (password != null && title.isNotEmpty) {
      await _passwordsService.updatePassword(
        documentId: password.documentId,
        text: title,
      );
    }
    if (password != null && email.isNotEmpty) {
      await _passwordsService.updatePassword(
        documentId: password.documentId,
        text: email,
      );
    }
    if (password != null && userpassword.isNotEmpty) {
      await _passwordsService.updatePassword(
        documentId: password.documentId,
        text: userpassword,
      );
    }
    if (password != null && url.isNotEmpty) {
      await _passwordsService.updatePassword(
        documentId: password.documentId,
        text: url,
      );
    }
  }

  @override
  void dispose() {
    _deletePasswordIfTextIsEmpty();
    _savePasswordIfTextNotEmpty();
    _titleController.dispose();
    _emailController.dispose();
    _userPasswordController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Password'),
        centerTitle: true,
        backgroundColor: Colors.purple[500],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              final text = _emailController.text;
              if (_password == null || text.isEmpty) {
                await showCannotShareEmptyPasswordDialog(context);
              } else {
                Share.share(text);
              }
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: FutureBuilder(
        future: createOrGetExistingPassword(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListener();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Title field
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child: TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your title here',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      //End of title field
                
                      //Email field
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your email here',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      //End of email field
                
                      //Password field
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child: TextField(
                          controller: _userPasswordController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your password here',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      //End of password field
                
                      //URL field
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        child: TextField(
                          controller: _urlController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your URL here',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      //End of URL field
                    ],
                    
                  ),
                ),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
