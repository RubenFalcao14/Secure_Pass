import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EmailView extends StatefulWidget {
  const EmailView({Key? key}) : super(key: key);

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {

  final controllerTo = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();

  @override
  void initState() {
    controllerTo.text = "securepass30@gmail.com";
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>Scaffold (
    appBar: AppBar(
      title: const Text("Email us", style: TextStyle(fontSize: 22),),
      centerTitle: true,
      backgroundColor: Colors.purple[500],
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          buildTextField(title: 'To',  controller: controllerTo,),
          const SizedBox(height: 16,),
          buildTextField(title: 'Subject',  controller: controllerSubject),
          const SizedBox(height: 16,),
          buildTextField(title: 'Message',  controller: controllerMessage, maxLines: 8,),
          const SizedBox(height: 16,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              textStyle: const TextStyle(fontSize: 30),
              primary: Colors.deepPurple,
            ),
            child: const Text('Send Email'),
            onPressed: () => launchEmail(
              toEmail: controllerTo.text,
              subject: controllerSubject.text,
              message: controllerMessage.text,
            ),
          ),
        ],
      ),
    ),
  );

  Future launchEmail({
    required String toEmail,
    required String subject,
    required String message,
  }) async{
    final url = 
      'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
      
      await canLaunchUrlString(url)
    ? await launchUrlString(url) : snackBar;
  }

  Widget buildTextField({
    required String title,
    required TextEditingController controller,
    int maxLines = 1,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8,),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            
            
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: controller,
                maxLines: maxLines,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          )

        ],
      );
      
  static const snackBar = SnackBar(
    content: Text('An error occured'),
  );
}