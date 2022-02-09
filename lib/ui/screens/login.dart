import 'package:flutter/material.dart';
import 'package:testing_app/services/auth.dart';
import 'package:testing_app/ui/screens/register.dart';

class LoginScreen extends StatelessWidget {
  final email = TextEditingController(), password = TextEditingController();
  final eNode = FocusNode(), pNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: [
          TextButton.icon(
            onPressed: () {
              Route route = MaterialPageRoute(builder: (_) => RegisterScreen());
              Navigator.pushReplacement(context, route);
            },
            icon: Icon(Icons.account_circle),
            label: Text("Register"),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              focusNode: eNode,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.mail),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: password,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              focusNode: pNode,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.password),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () async {
                await UserAuthentication().loginWithEmailPassword(email.text, password.text);
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}