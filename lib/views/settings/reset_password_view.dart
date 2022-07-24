import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_pass/services/auth/auth_exceptions.dart';
import 'package:secure_pass/utilities/dialogs/error_dialog.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _email = TextEditingController();

  Widget buildButton() {
    return ElevatedButton(
      child: const Text('Reset Password'),
      onPressed: () async{
       await passwordReset();
      },
    );
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
      showDialog(
        context: context, 
        builder: (context) {
          return const AlertDialog(
            content : Text('Password reset link sent! Check your email'),
          );
        }
      );
    } on UserNotFoundAuthException {
        await showErrorDialog(
          context,
          'User not found',
        );
    } on InvalidEmailAuthException {
        await showErrorDialog(
          context,
          'This is an invalid email address',
        );
      } on GenericAuthException {
        await showErrorDialog(
          context,
          'Please try again',
        );
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
        backgroundColor: Colors.purple[500],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.0),
            child: Text(
              "Enter your Email and we will send you a password reset link",
              textAlign: TextAlign.center,
              style: TextStyle( 
                fontSize: 20,
              ),
            ),
            
          ),
          const SizedBox(height: 20),

          //email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email here',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            buildButton(),

        ],
      ),
    );
  }
}