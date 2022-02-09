import 'package:flutter/material.dart';
import 'package:testing_app/services/auth.dart';
import 'package:testing_app/ui/screens/login.dart';

class RegisterScreen extends StatelessWidget {
  final email = TextEditingController(),
      password = TextEditingController(),
      name = TextEditingController(),
      phone = TextEditingController();

  final eNode = FocusNode(),
      pNode = FocusNode(),
      cNode = FocusNode(),
      nNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        actions: [
          TextButton.icon(
            onPressed: () {
              Route route = MaterialPageRoute(builder: (_) => LoginScreen());
              Navigator.pushReplacement(context, route);
            },
            icon: Icon(Icons.account_circle),
            label: Text("Login"),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: name,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              focusNode: nNode,
              decoration: InputDecoration(
                hintText: 'Name',
                prefixIcon: Icon(Icons.perm_identity),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
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
              controller: phone,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              focusNode: cNode,
              decoration: InputDecoration(
                hintText: 'Phone',
                prefixIcon: Icon(Icons.phone_android),
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
              onPressed: () => UserAuthentication().signUp(email.text, password.text, phone.text, name.text),
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
