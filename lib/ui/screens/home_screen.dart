import 'package:flutter/material.dart';

import '../../services/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Page"),
        actions: [
          IconButton(
              onPressed: () {
                UserAuthentication().logout();
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Text("Welcome to home page"),
          ],
        ),
      ),
    );
  }
}
