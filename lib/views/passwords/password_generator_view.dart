import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_pass/views/passwords/password_generator.dart';

class PasswordGeneratorView extends StatefulWidget {
  const PasswordGeneratorView({Key? key}) : super(key: key);

  @override
  State<PasswordGeneratorView> createState() => _PasswordGeneratorViewState();
}

class _PasswordGeneratorViewState extends State<PasswordGeneratorView> {
  final controller = TextEditingController();

  Widget buildButton() {
    return ElevatedButton(
      child: const Text('Generate Password'),
      onPressed: () {
        String _generatedPassword = generatePassword(true, true, true, true, 20);
        controller.text = _generatedPassword;
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password Generator"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Random Password Generator',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              readOnly: true,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    final data = ClipboardData(text: controller.text);
                    Clipboard.setData(data);

                  final snackBar = SnackBar(
                    content: Text(
                      'Password Copied',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.red
                  );

                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  }, 
                )
              ),
            ),
            const SizedBox(height: 32),
            buildButton(),
          ],
        ),
      ),
    );
  }
}