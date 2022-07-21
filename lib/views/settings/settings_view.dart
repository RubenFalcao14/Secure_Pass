import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secure_pass/theme/theme_manager.dart';
import 'package:secure_pass/views/settings/reset_password_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

ThemeManager _themeManager = ThemeManager();

class _SettingsViewState extends State<SettingsView> {

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener(){
    if(mounted) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(fontSize: 22),),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 40),

            //Dark mode
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dark Mode", 
                  style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey,
                  ).copyWith(
                    color: isDark?Colors.white:Colors.black,
                  ),
                ),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: _themeManager.themeMode == ThemeMode.dark, onChanged: (newValue) {
                      _themeManager.toogleTheme(newValue);
                    },
                  ),
                ),
                ],
              ),
            //end of dark mode

            //Account section
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                const SizedBox(width: 10),
                Text("Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold).copyWith(
                    color: isDark?Colors.white:Colors.black,
                  ),
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

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Change Password", style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey,
                  ).copyWith(
                    color: isDark?Colors.white:Colors.black,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.black),
                ],
              ),
            ),
            //End of change password

            //Delete Account
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return const ResetPasswordView();
                    }
                  )
                );
              },

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Delete Account", style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey,
                  ).copyWith(
                    color: isDark?Colors.white:Colors.black,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.black),
                ],
              ),
            ),
            //End of delete account

            //Email Us
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return const ResetPasswordView();
                    }
                  )
                );
              },

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Email Us", style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey,
                  ).copyWith(
                    color: isDark?Colors.white:Colors.black,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.black),
                ],
              ),
            ),
            //End of Email Us
            //End of account section
            
          ],
        ),
      ),
    );
  }
}