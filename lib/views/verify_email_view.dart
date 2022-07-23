import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_pass/constants/routes.dart';
import 'package:secure_pass/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                //Verify your Email
                Text(
                  'Verify your Email',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Check your email and click on the link to verify your email',
                    textAlign: TextAlign.center,
                    style: TextStyle( 
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                //email icon
                const Icon(
                 Icons.email,
                 size: 200,
                ),
                const SizedBox(height: 40),

          //Resend email      
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Center(
              child: Text(
                'Resend email',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          //end of Resend email

          //code for continue
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(loginRoute);
            },
            // async {
            //   var user = AuthService.firebase().currentUser;
            //   // await user?.reload();
            //   // user = await AuthService.firebase().currentUser();
            //   if (user?.isEmailVerified ?? false) {
            //     // user's email is verified
            //     Navigator.of(context).pushNamedAndRemoveUntil(
            //       passwordsRoute,
            //       (route) => false,
            //     );
            //   } else {
            //     // user's email is NOT verified
            //     Navigator.of(context).pushNamedAndRemoveUntil(
            //       verifyEmailRoute,
            //       (route) => false,
            //     );
            //   }
            // },
            
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25), 
        //end of continue         

        //Change email
        TextButton(
          onPressed: () async {
            await AuthService.firebase().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute,
              (route) => false,
            );
          },
          child: const Center(
              child: Text(
                'Change email',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        )
        //end of change email

        ],
      ),
      ),
      ),
      ),
    );
  }
}
