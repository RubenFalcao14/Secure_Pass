import 'package:flutter/material.dart';
import 'package:secure_pass/constants/routes.dart';
import 'package:secure_pass/services/auth/auth_service.dart';
import 'package:secure_pass/utilities/dialogs/logout_dialog.dart';
import 'package:secure_pass/views/settings/delete_account_view.dart';
import 'package:secure_pass/views/settings/email_view.dart';
import 'package:secure_pass/views/settings/reset_password_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(fontSize: 22),),
        centerTitle: true,
        backgroundColor: Colors.purple[500],
        elevation: 0,
      ),
      body: ListView(
          children: [
            const SizedBox(height: 40),

            //Account section
            Row(
              children: const [
                Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text("Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                ),
              ],
            ),
            const Divider(height: 20, thickness: 2),
            const SizedBox(height: 10),
          
            //Change Password
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return const ResetPasswordView();
                    }
                  ),
                );
              },

                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.security, color: Colors.red),
                        Text("Change Password", style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey,
                        )
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.black),
                      ],
                    ),
                  ),
                ),
            ),
            const SizedBox(height: 20),
            //End of change password

            //Log out
            GestureDetector(
              onTap: () async{
                final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false,
                    );
                  }
              },

                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.logout, color: Colors.blue),
                        Text("Log Out", style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey,
                        )
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.black),
                      ],
                    ),
                  ),
                ),
            ),
            const SizedBox(height: 20),
            //End of logout

            //Delete Account
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return const DeleteAccountView();
                    }
                  )
                );
              },

                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.delete, color: Colors.purple),
                        Text("Delete Account", style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey,
                        )
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.black),
                      ],
                    ),
                  ),
                ),
            ),
            const SizedBox(height: 20),
            //End of delete account

            //Email Us
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return const EmailView();
                    }
                  )
                );
              },

                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.email, color: Colors.amber),
                        Text("Email Us", style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            //End of Email Us
            //End of account section
            
          ],
        ),
    );
  }
}