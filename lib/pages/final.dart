import 'package:flutter/material.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Final extends StatefulWidget {
  const Final({Key? key}) : super(key: key);

  @override
  _FinalState createState() => _FinalState();
}

class _FinalState extends State<Final> {

  Map data = {};

  sendMail() async {
    String username = 'alertdtibatch5@gmail.com';
    String password = 'iwcrjfhquzyluinm';

    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(data["email"])
      // ..ccRecipients.addAll(['destCc1@exam/ple.com', 'destCc2@example.com'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Accident Alert ❗⚠: ${DateTime.now()}'
      ..text = ""
      ..html = "<h1>Accident Alert ! Emergency</h1>\n<p>Your friend is in danger !\nYour friend needs emergency care\nLocation: https://www.google.com/maps/search/?api=1&query=${data["latitude"]},${data["longitude"]}</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)!.settings.arguments as Map;

    sendMail();

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "!",
          style: TextStyle(
            color: Color(0xFFEDF0DA),
            fontWeight: FontWeight.w700,
            fontSize: 24.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                'assets/images/alarm.png',
              width: 200.0,
            ),
            SizedBox(height: 20.0,),
            Text(
              "Emergency Services Triggered",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 24.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}