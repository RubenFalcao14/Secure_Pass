import 'package:flutter/material.dart';
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
        title: Text("Settings", style: TextStyle(fontSize: 22),),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Row(
              children: const[
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text("Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
              ],
            ),
            Divider(height: 20, thickness: 2),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return ResetPasswordView();
                    }
                  )
                );
              },

              //Reset Password
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                  Text("Change Password", style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ],
              ),


            )
          ],
        ),
      ),
    );
  }
}