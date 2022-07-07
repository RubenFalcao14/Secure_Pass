import 'package:flutter/material.dart';
import 'package:secure_pass/constants/routes.dart';
import 'package:secure_pass/services/auth/auth_service.dart';
import 'package:secure_pass/views/login_view.dart';
import 'package:secure_pass/views/passwords/create_update_password_view.dart';
import 'package:secure_pass/views/passwords/password_generator_view.dart';
import 'package:secure_pass/views/passwords/passwords_view.dart';
import 'package:secure_pass/views/register_view.dart';
import 'package:secure_pass/views/settings/settings_view.dart';
import 'package:secure_pass/views/verify_email_view.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.cyan,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        passwordsRoute: (context) => const PasswordsView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdatePasswordRoute: (context) => const CreateUpdatePasswordView(),
        passwordGeneratorRoute : (context) => const PasswordGeneratorView(),
        settingsRoute : (context) => const SettingsView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));

    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const PasswordsView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
